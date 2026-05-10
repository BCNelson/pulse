# Multi-stage build: produce a single static binary, then ship it on a
# distroless base so the runtime image stays under ~30MB.

ARG GO_VERSION=1.26

FROM golang:${GO_VERSION}-alpine AS builder
WORKDIR /src
RUN apk add --no-cache build-base ca-certificates

# Cache deps separately from sources.
COPY services/api/go.mod services/api/go.sum services/api/
COPY go.work go.work.sum ./
WORKDIR /src/services/api
RUN go mod download

WORKDIR /src
COPY services/api ./services/api

WORKDIR /src/services/api
RUN CGO_ENABLED=0 GOOS=linux GOARCH=$(go env GOARCH) \
    go build -ldflags='-s -w' -o /out/pulse-api ./cmd/api && \
    CGO_ENABLED=0 GOOS=linux GOARCH=$(go env GOARCH) \
    go build -ldflags='-s -w' -o /out/pulse-bootstrap ./cmd/bootstrap

# Migrations are SQL files that the binary applies on startup.
COPY db/migrations /out/migrations

FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=builder /out/pulse-api /usr/local/bin/pulse-api
COPY --from=builder /out/pulse-bootstrap /usr/local/bin/pulse-bootstrap
COPY --from=builder /out/migrations /etc/pulse/migrations

ENV GOOSE_MIGRATION_DIR=/etc/pulse/migrations
EXPOSE 8080
USER nonroot
ENTRYPOINT ["/usr/local/bin/pulse-api"]
