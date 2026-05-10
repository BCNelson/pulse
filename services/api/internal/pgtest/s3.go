// S3 testcontainer harness for attachment integration tests. RustFS is an
// S3-compatible object storage server; we run it in a single container per
// test process and create the attachments bucket once. Tests get a shared
// aws-sdk-go-v2 client back; namespace keys with t.Name() to stay isolated.
package pgtest

import (
	"context"
	"fmt"
	"net"
	"sync"
	"testing"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/wait"
)

const (
	rustfsImage     = "rustfs/rustfs:latest"
	rustfsAccessKey = "pulse-test"
	rustfsSecretKey = "pulse-test-secret"
	rustfsBucket    = "pulse-attachments"
	rustfsRegion    = "us-east-1"
)

var (
	s3Once     sync.Once
	s3Endpoint string
	s3Err      error
)

func startS3() {
	ctx := context.Background()
	req := testcontainers.ContainerRequest{
		Image:        rustfsImage,
		ExposedPorts: []string{"9000/tcp"},
		Env: map[string]string{
			"RUSTFS_ACCESS_KEY": rustfsAccessKey,
			"RUSTFS_SECRET_KEY": rustfsSecretKey,
		},
		WaitingFor: wait.ForHTTP("/").
			WithPort("9000/tcp").
			WithStatusCodeMatcher(func(code int) bool {
				// An S3-compatible endpoint returns 200/400/403 at the root —
				// any of those means the server is listening and speaking S3.
				return code == 200 || code == 400 || code == 403
			}),
	}
	c, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: req,
		Started:          true,
	})
	if err != nil {
		s3Err = fmt.Errorf("start rustfs container: %w", err)
		return
	}
	host, err := c.Host(ctx)
	if err != nil {
		s3Err = fmt.Errorf("rustfs host: %w", err)
		return
	}
	port, err := c.MappedPort(ctx, "9000/tcp")
	if err != nil {
		s3Err = fmt.Errorf("rustfs port: %w", err)
		return
	}
	s3Endpoint = fmt.Sprintf("http://%s", net.JoinHostPort(host, port.Port()))

	if _, err := newS3Client(s3Endpoint).CreateBucket(ctx, &s3.CreateBucketInput{
		Bucket: aws.String(rustfsBucket),
	}); err != nil {
		s3Err = fmt.Errorf("create bucket: %w", err)
		return
	}
}

// S3 returns an aws-sdk-go-v2 S3 client wired to a shared RustFS testcontainer
// and the name of the pre-created bucket. The container is started lazily on
// first call. Tests sharing the bucket should namespace their keys (e.g., by
// t.Name()) to avoid collisions.
func S3(t *testing.T) (*s3.Client, string) {
	t.Helper()
	s3Once.Do(startS3)
	if s3Err != nil {
		t.Fatalf("%v", s3Err)
	}
	return newS3Client(s3Endpoint), rustfsBucket
}

func newS3Client(endpoint string) *s3.Client {
	return s3.NewFromConfig(aws.Config{
		Region:      rustfsRegion,
		Credentials: credentials.NewStaticCredentialsProvider(rustfsAccessKey, rustfsSecretKey, ""),
	}, func(o *s3.Options) {
		o.BaseEndpoint = aws.String(endpoint)
		o.UsePathStyle = true
	})
}
