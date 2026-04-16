/// Environment-specific configuration
/// 
/// Usage: Access via AppConfig.fromEnvironment()
/// 
/// Values are set via --dart-define during build:
/// - ENV=dev, staging, or prod
/// - API_URL=https://api.example.com
class AppConfig {
  final String environment;
  final String apiUrl;
  final bool isDebug;
  final bool isStaging;
  final bool isProduction;

  AppConfig({
    required this.environment,
    required this.apiUrl,
    required this.isDebug,
    required this.isStaging,
    required this.isProduction,
  });

  /// Create config from compile-time constants
  factory AppConfig.fromEnvironment() {
    const env = String.fromEnvironment('ENV', defaultValue: 'dev');
    const apiUrl = String.fromEnvironment(
      'API_URL',
      defaultValue: 'https://dev-api.example.com',
    );

    return AppConfig(
      environment: env,
      apiUrl: apiUrl,
      isDebug: env == 'dev',
      isStaging: env == 'staging',
      isProduction: env == 'prod',
    );
  }

  /// Get API endpoint for a specific path
  String getApiEndpoint(String path) {
    return '$apiUrl$path';
  }

  @override
  String toString() {
    return 'AppConfig(environment: $environment, apiUrl: $apiUrl)';
  }
}
