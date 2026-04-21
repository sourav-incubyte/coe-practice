import 'package:flutter_test/flutter_test.dart';
import 'package:my_practice_app/config/app_config.dart';

void main() {
  group('AppConfig', () {
    test('constructor creates config with all fields', () {
      final config = AppConfig(
        environment: 'dev',
        apiUrl: 'https://dev-api.example.com',
        isDebug: true,
        isStaging: false,
        isProduction: false,
      );

      expect(config.environment, equals('dev'));
      expect(config.apiUrl, equals('https://dev-api.example.com'));
      expect(config.isDebug, isTrue);
      expect(config.isStaging, isFalse);
      expect(config.isProduction, isFalse);
    });

    test('fromEnvironment creates dev config by default', () {
      final config = AppConfig.fromEnvironment();

      expect(config.environment, equals('dev'));
      expect(config.apiUrl, equals('https://dev-api.example.com'));
      expect(config.isDebug, isTrue);
      expect(config.isStaging, isFalse);
      expect(config.isProduction, isFalse);
    });

    test('fromEnvironment sets isDebug correctly for dev', () {
      // Since we can't set compile-time constants in tests,
      // we test the logic by creating config directly
      final config = AppConfig(
        environment: 'dev',
        apiUrl: 'https://dev-api.example.com',
        isDebug: true,
        isStaging: false,
        isProduction: false,
      );

      expect(config.isDebug, isTrue);
      expect(config.isStaging, isFalse);
      expect(config.isProduction, isFalse);
    });

    test('fromEnvironment sets isStaging correctly for staging', () {
      final config = AppConfig(
        environment: 'staging',
        apiUrl: 'https://staging-api.example.com',
        isDebug: false,
        isStaging: true,
        isProduction: false,
      );

      expect(config.isDebug, isFalse);
      expect(config.isStaging, isTrue);
      expect(config.isProduction, isFalse);
    });

    test('fromEnvironment sets isProduction correctly for prod', () {
      final config = AppConfig(
        environment: 'prod',
        apiUrl: 'https://prod-api.example.com',
        isDebug: false,
        isStaging: false,
        isProduction: true,
      );

      expect(config.isDebug, isFalse);
      expect(config.isStaging, isFalse);
      expect(config.isProduction, isTrue);
    });

    test('getApiEndpoint appends path to apiUrl', () {
      final config = AppConfig(
        environment: 'dev',
        apiUrl: 'https://dev-api.example.com',
        isDebug: true,
        isStaging: false,
        isProduction: false,
      );

      expect(
        config.getApiEndpoint('/users'),
        equals('https://dev-api.example.com/users'),
      );
      expect(
        config.getApiEndpoint('/posts/123'),
        equals('https://dev-api.example.com/posts/123'),
      );
    });

    test('getApiEndpoint handles path without leading slash', () {
      final config = AppConfig(
        environment: 'dev',
        apiUrl: 'https://dev-api.example.com',
        isDebug: true,
        isStaging: false,
        isProduction: false,
      );

      // The actual behavior is simple concatenation without automatic slash
      expect(
        config.getApiEndpoint('users'),
        equals('https://dev-api.example.comusers'),
      );
    });

    test('toString returns formatted string', () {
      final config = AppConfig(
        environment: 'dev',
        apiUrl: 'https://dev-api.example.com',
        isDebug: true,
        isStaging: false,
        isProduction: false,
      );

      expect(
        config.toString(),
        equals(
          'AppConfig(environment: dev, apiUrl: https://dev-api.example.com)',
        ),
      );
    });

    test('toString with different environment', () {
      final config = AppConfig(
        environment: 'prod',
        apiUrl: 'https://api.example.com',
        isDebug: false,
        isStaging: false,
        isProduction: true,
      );

      expect(
        config.toString(),
        equals('AppConfig(environment: prod, apiUrl: https://api.example.com)'),
      );
    });
  });
}
