import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// EXERCISE 5: Global Error Handling Strategies
// PROBLEM: Errors can happen outside try-catch blocks (timers, isolates, etc.)
// TASK: Implement global error handlers to catch uncaught errors

// ===== GLOBAL ERROR HANDLERS =====

class GlobalErrorHandler {
  static void initialize() {
    // Handle Flutter framework errors
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      _logError('Flutter Error', details.exception, details.stack);
      // In production, send to crash reporting service
      // Crashlytics.instance.recordFlutterError(details);
    };

    // Handle asynchronous errors outside Flutter framework
    PlatformDispatcher.instance.onError = (error, stack) {
      _logError('Platform Error', error, stack);
      // In production, send to crash reporting service
      // Crashlytics.instance.recordError(error, stack, fatal: true);
      return true; // Error handled
    };
  }

  static void _logError(String type, dynamic error, StackTrace? stack) {
    debugPrint('[$type] $error');
    if (stack != null) {
      debugPrint(stack.toString());
    }
  }
}

// ===== ERROR LOGGING SERVICE =====

class ErrorLoggingService {
  static final List<ErrorLog> _errorLogs = [];

  static void logError(String message, {StackTrace? stack, String? code}) {
    _errorLogs.add(
      ErrorLog(
        message: message,
        timestamp: DateTime.now(),
        stackTrace: stack?.toString(),
        code: code,
      ),
    );
  }

  static List<ErrorLog> get errorLogs => List.unmodifiable(_errorLogs);

  static void clearLogs() => _errorLogs.clear();
}

class ErrorLog {
  final String message;
  final DateTime timestamp;
  final String? stackTrace;
  final String? code;

  ErrorLog({
    required this.message,
    required this.timestamp,
    this.stackTrace,
    this.code,
  });
}

// ===== DEMO APP =====
class GlobalErrorHandlingExerciseApp extends StatelessWidget {
  const GlobalErrorHandlingExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Error Handling Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const GlobalErrorHandlingScreen(),
    );
  }
}

class GlobalErrorHandlingScreen extends StatefulWidget {
  const GlobalErrorHandlingScreen({super.key});

  @override
  State<GlobalErrorHandlingScreen> createState() =>
      _GlobalErrorHandlingScreenState();
}

class _GlobalErrorHandlingScreenState extends State<GlobalErrorHandlingScreen> {
  bool _globalHandlerInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeGlobalHandler();
  }

  void _initializeGlobalHandler() {
    GlobalErrorHandler.initialize();
    setState(() => _globalHandlerInitialized = true);
  }

  void _triggerFlutterError() {
    // This will be caught by FlutterError.onError
    try {
      throw Exception('This is a Flutter framework error');
    } catch (e) {
      // Re-throw to trigger global handler
      rethrow;
    }
  }

  void _triggerAsyncError() {
    // This will be caught by PlatformDispatcher.instance.onError
    Future.delayed(const Duration(seconds: 1), () {
      throw Exception('This is an async error outside Flutter framework');
    });
  }

  void _triggerValidationError() {
    ErrorLoggingService.logError(
      'Validation failed: Invalid input',
      code: 'VALIDATION_ERROR',
    );
    setState(() {});
  }

  void _triggerNetworkError() {
    ErrorLoggingService.logError(
      'Network request failed: Connection timeout',
      code: 'NETWORK_TIMEOUT',
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final errorLogs = ErrorLoggingService.errorLogs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5: Global Error Handling'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _globalHandlerInitialized
                              ? Icons.check_circle
                              : Icons.warning,
                          color: _globalHandlerInitialized
                              ? Colors.green
                              : Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _globalHandlerInitialized
                              ? 'Global error handler initialized'
                              : 'Global error handler not initialized',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Global Error Handlers:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildHandlerCard(
                      'FlutterError.onError',
                      'Catches errors in Flutter framework',
                      Colors.blue,
                      '```dart\nFlutterError.onError = (details) {\n  // Log to crash reporting\n  Crashlytics.recordFlutterError(details);\n};\n```',
                    ),
                    const SizedBox(height: 10),
                    _buildHandlerCard(
                      'PlatformDispatcher.onError',
                      'Catches async errors outside Flutter',
                      Colors.green,
                      '```dart\nPlatformDispatcher.instance.onError = (error, stack) {\n  // Log to crash reporting\n  Crashlytics.recordError(error, stack);\n  return true;\n};\n```',
                    ),
                    const SizedBox(height: 10),
                    _buildHandlerCard(
                      'ErrorLoggingService',
                      'Custom logging service for app errors',
                      Colors.orange,
                      '```dart\nErrorLoggingService.logError(\n  message,\n  code: \'ERROR_CODE\',\n);\n```',
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),
                    const Text(
                      'Test Error Handlers:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      children: [
                        ElevatedButton(
                          onPressed: _triggerValidationError,
                          child: const Text('Log Validation Error'),
                        ),
                        ElevatedButton(
                          onPressed: _triggerNetworkError,
                          child: const Text('Log Network Error'),
                        ),
                        ElevatedButton(
                          onPressed: _triggerFlutterError,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text('Trigger Flutter Error'),
                        ),
                        ElevatedButton(
                          onPressed: _triggerAsyncError,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('Trigger Async Error'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() => ErrorLoggingService.clearLogs());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Clear Logs'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: errorLogs.isEmpty
                ? const Center(
                    child: Text(
                      'No error logs yet. Click buttons above to test.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: errorLogs.length,
                    itemBuilder: (context, index) {
                      final log = errorLogs[index];
                      return Card(
                        color: Colors.red.withOpacity(0.1),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    log.code ?? 'UNKNOWN_ERROR',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(log.message),
                              const SizedBox(height: 4),
                              Text(
                                log.timestamp.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandlerCard(
    String title,
    String description,
    Color color,
    String code,
  ) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.settings, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(description),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                code,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
