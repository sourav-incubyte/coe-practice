import 'package:flutter/material.dart';

// EXERCISE 6: Error Boundary Widgets
// PROBLEM: Errors in widget tree can crash entire app
// TASK: Implement error boundary widgets to isolate errors

// ===== ERROR BOUNDARY WIDGET =====

class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(Object error, StackTrace? stack)? onError;
  final String? errorMessage;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.onError,
    this.errorMessage,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Object? _error;
  StackTrace? _stack;

  @override
  void initState() {
    super.initState();
    _initializeErrorWidget();
  }

  void _initializeErrorWidget() {
    ErrorWidget.builder = (details) {
      return _error != null && widget.onError != null
          ? widget.onError!(_error!, _stack)
          : _buildDefaultErrorWidget(details.exception, details.stack);
    };
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Widget _buildDefaultErrorWidget(Object error, StackTrace? stack) {
    return Material(
      child: Container(
        color: Colors.red[50],
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Something went wrong',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.errorMessage ?? error.toString(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _error = null;
                  _stack = null;
                });
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== FALLBACK WIDGET =====

class ErrorFallbackWidget extends StatelessWidget {
  final Object error;
  final StackTrace? stack;
  final VoidCallback? onRetry;

  const ErrorFallbackWidget({
    super.key,
    required this.error,
    this.stack,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[50],
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          const Text(
            'Widget Error',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 16),
          if (onRetry != null)
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
        ],
      ),
    );
  }
}

// ===== SAFE BUILDER =====

class SafeBuilder extends StatelessWidget {
  final Widget Function() builder;
  final Widget Function(Object error)? fallback;

  const SafeBuilder({
    super.key,
    required this.builder,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return builder();
    } catch (error, stack) {
      debugPrint('SafeBuilder caught error: $error');
      debugPrint(stack.toString());
      return fallback != null
          ? fallback!(error)
          : ErrorFallbackWidget(error: error, stack: stack);
    }
  }
}

// ===== DEMO WIDGETS THAT CAN FAIL =====

class FailingWidget extends StatelessWidget {
  final bool shouldFail;

  const FailingWidget({super.key, this.shouldFail = false});

  @override
  Widget build(BuildContext context) {
    if (shouldFail) {
      throw Exception('This widget failed to build');
    }
    return Container(
      color: Colors.green[100],
      padding: const EdgeInsets.all(16),
      child: const Column(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 48),
          Text('This widget is working correctly'),
        ],
      ),
    );
  }
}

class AsyncFailingWidget extends StatefulWidget {
  const AsyncFailingWidget({super.key});

  @override
  State<AsyncFailingWidget> createState() => _AsyncFailingWidgetState();
}

class _AsyncFailingWidgetState extends State<AsyncFailingWidget> {
  bool _shouldFail = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (_shouldFail) {
        throw Exception('Async widget failed');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Icon(Icons.sync, color: Colors.blue, size: 48),
          const Text('Async Widget'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() => _shouldFail = true);
            },
            child: const Text('Trigger Error'),
          ),
        ],
      ),
    );
  }
}

// ===== DEMO APP =====
class ErrorBoundaryExerciseApp extends StatelessWidget {
  const ErrorBoundaryExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error Boundary Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const ErrorBoundaryScreen(),
    );
  }
}

class ErrorBoundaryScreen extends StatefulWidget {
  const ErrorBoundaryScreen({super.key});

  @override
  State<ErrorBoundaryScreen> createState() => _ErrorBoundaryScreenState();
}

class _ErrorBoundaryScreenState extends State<ErrorBoundaryScreen> {
  bool _widget1ShouldFail = false;
  bool _widget2ShouldFail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 6: Error Boundary'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Error Boundary Widgets',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Error boundaries isolate errors to prevent app crashes',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Example 1: SafeBuilder',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SafeBuilder(
              builder: () => FailingWidget(shouldFail: _widget1ShouldFail),
              fallback: (error) => ErrorFallbackWidget(
                error: error,
                onRetry: () => setState(() => _widget1ShouldFail = false),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Switch(
                  value: _widget1ShouldFail,
                  onChanged: (value) => setState(() => _widget1ShouldFail = value),
                ),
                const SizedBox(width: 8),
                const Text('Trigger Error'),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Example 2: Error Boundary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ErrorBoundary(
              errorMessage: 'Widget failed to load',
              onError: (error, stack) => ErrorFallbackWidget(
                error: error,
                stack: stack,
                onRetry: () => setState(() => _widget2ShouldFail = false),
              ),
              child: FailingWidget(shouldFail: _widget2ShouldFail),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Switch(
                  value: _widget2ShouldFail,
                  onChanged: (value) => setState(() => _widget2ShouldFail = value),
                ),
                const SizedBox(width: 8),
                const Text('Trigger Error'),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Example 3: Async Error Handling',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const AsyncFailingWidget(),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Benefits of Error Boundaries:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildBenefitCard('Prevent App Crashes', 'Isolate errors to specific widget trees'),
            _buildBenefitCard('User-Friendly Errors', 'Show custom error messages instead of red screen'),
            _buildBenefitCard('Graceful Degradation', 'Show fallback UI when errors occur'),
            _buildBenefitCard('Error Recovery', 'Allow users to retry failed operations'),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'When to Use Error Boundaries:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildUseCaseCard('Third-party widgets', 'Wrap widgets you don\'t control'),
            _buildUseCaseCard('Complex computations', 'Isolate heavy calculations'),
            _buildUseCaseCard('Async operations', 'Handle network requests safely'),
            _buildUseCaseCard('Feature toggles', 'Gracefully handle missing features'),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitCard(String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }

  Widget _buildUseCaseCard(String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.info, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}
