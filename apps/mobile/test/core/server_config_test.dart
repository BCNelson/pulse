import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/server_config.dart';

void main() {
  group('parseServerUrl', () {
    test('bare domain defaults to https on port 443', () {
      final c = parseServerUrl('example.com');
      expect(c.baseUrl, 'https://example.com:443');
      expect(c.graphqlHttpUrl, 'https://example.com:443/graphql');
      expect(c.graphqlWsUrl, 'wss://example.com:443/graphql');
    });

    test('explicit https no port fills in 443', () {
      final c = parseServerUrl('https://example.com');
      expect(c.baseUrl, 'https://example.com:443');
      expect(c.graphqlHttpUrl, 'https://example.com:443/graphql');
      expect(c.graphqlWsUrl, 'wss://example.com:443/graphql');
    });

    test('bare domain with explicit port keeps it', () {
      final c = parseServerUrl('example.com:8080');
      expect(c.baseUrl, 'https://example.com:8080');
      expect(c.graphqlHttpUrl, 'https://example.com:8080/graphql');
      expect(c.graphqlWsUrl, 'wss://example.com:8080/graphql');
    });

    test('http scheme with explicit port keeps it', () {
      final c = parseServerUrl('http://localhost:8080');
      expect(c.baseUrl, 'http://localhost:8080');
      expect(c.graphqlHttpUrl, 'http://localhost:8080/graphql');
      expect(c.graphqlWsUrl, 'ws://localhost:8080/graphql');
    });

    test('http scheme without port fills in 80', () {
      final c = parseServerUrl('http://localhost');
      expect(c.baseUrl, 'http://localhost:80');
      expect(c.graphqlHttpUrl, 'http://localhost:80/graphql');
      expect(c.graphqlWsUrl, 'ws://localhost:80/graphql');
    });

    test('trims whitespace and trailing slashes', () {
      final c = parseServerUrl('  https://example.com/  ');
      expect(c.baseUrl, 'https://example.com:443');
    });

    test('strips multiple trailing slashes', () {
      final c = parseServerUrl('https://example.com////');
      expect(c.baseUrl, 'https://example.com:443');
    });

    test('uppercase scheme is normalized', () {
      final c = parseServerUrl('HTTPS://example.com');
      expect(c.baseUrl, 'https://example.com:443');
    });

    test('host with dashes and hyphens works', () {
      final c = parseServerUrl('my-server.lan:8080');
      expect(c.baseUrl, 'https://my-server.lan:8080');
    });

    test('rejects empty string', () {
      expect(() => parseServerUrl(''), throwsFormatException);
    });

    test('rejects whitespace-only', () {
      expect(() => parseServerUrl('   '), throwsFormatException);
    });

    test('rejects unsupported scheme', () {
      expect(() => parseServerUrl('ftp://example.com'),
          throwsFormatException);
      expect(() => parseServerUrl('ws://example.com'), throwsFormatException);
    });

    test('rejects scheme with no host', () {
      expect(() => parseServerUrl('https://'), throwsFormatException);
    });
  });
}
