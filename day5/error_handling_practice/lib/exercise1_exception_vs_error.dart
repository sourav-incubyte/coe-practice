import 'package:flutter/material.dart';

// EXERCISE 1: Exception vs Error Fundamentals
// PROBLEM: Not understanding when to use Exception vs Error
// TASK: Learn the difference and when to catch each

// ===== EXCEPTION (Handleable) =====
// Exceptions are conditions that a program should be able to handle
// Examples: Network failure, invalid input, file not found

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class ValidationException implements Exception {
  final String field;
  final String message;
  ValidationException(this.field, this.message);

  @override
  String toString() => 'ValidationException on $field: $message';
}

// ===== ERROR (Unhandleable - Fix the code) =====
// Errors indicate bugs in your code that should be fixed, not caught
// Examples: RangeError, TypeError, OutOfMemoryError

// DON'T DO THIS - Don't catch errors!
void badErrorHandling() {
  try {
    final list = [1, 2, 3];
    print(list[10]); // RangeError
  } on RangeError catch (e) {
    print('Caught RangeError: $e'); // BAD! Fix the bug instead
  }
}

// DO THIS - Fix the bug
void goodErrorHandling() {
  final list = [1, 2, 3];
  if (list.length > 10) {
    print(list[10]); // Safe access with bounds checking
  } else {
    print('Index out of range'); // Handle the condition properly
  }
}

// ===== DEMO APP =====
class ExceptionVsErrorExerciseApp extends StatelessWidget {
  const ExceptionVsErrorExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exception vs Error Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const ExceptionVsErrorScreen(),
    );
  }
}

class ExceptionVsErrorScreen extends StatelessWidget {
  const ExceptionVsErrorScreen({super.key});

  // Simulate a network operation that can fail
  Future<String> fetchUserData() async {
    // Simulate network failure
    throw NetworkException('Internet connection lost');
  }

  // Simulate validation that can fail
  void validateEmail(String email) {
    if (!email.contains('@')) {
      throw ValidationException('email', 'Invalid email format');
    }
  }

  // Demonstrate proper exception handling
  Future<void> handleNetworkCall() async {
    try {
      await fetchUserData();
    } catch (error) {
      print('Handled network error: $error');
    }
  }

  // Demonstrate proper validation
  String handleValidation(String email) {
    try {
      validateEmail(email);
      return 'Email is valid';
    } on ValidationException catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1: Exception vs Error'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Exception vs Error in Dart',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildInfoCard('Exception', Colors.green, 'Handleable conditions', [
              'Network failures',
              'Invalid user input',
              'File not found',
              'Parse errors',
              'You SHOULD catch these',
            ]),
            const SizedBox(height: 20),
            _buildInfoCard('Error', Colors.red, 'Programmatic failures', [
              'RangeError (index out of bounds)',
              'TypeError (wrong type)',
              'OutOfMemoryError',
              'StateError (wrong state)',
              'You SHOULD FIX these, not catch',
            ]),
            const SizedBox(height: 30),
            const Text(
              'Exception Examples (Handleable):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildExampleCard(
              'NetworkException',
              'Internet connection lost',
              'Catch and show user-friendly message',
              Colors.blue,
            ),
            const SizedBox(height: 10),
            _buildExampleCard(
              'ValidationException',
              'Invalid email format',
              'Catch and show field-specific error',
              Colors.orange,
            ),
            const SizedBox(height: 30),
            const Text(
              'Error Examples (Fix the code):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildExampleCard(
              'RangeError',
              'list[10] when list has only 3 items',
              'Add bounds checking: if (list.length > 10)',
              Colors.red,
            ),
            const SizedBox(height: 10),
            _buildExampleCard(
              'TypeError',
              'Calling int method on String',
              'Fix type: ensure correct types',
              Colors.red,
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Live Demo:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final result = handleValidation('invalid-email');
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(result)));
              },
              child: const Text('Test Validation Exception'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final result = handleValidation('valid@email.com');
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(result)));
              },
              child: const Text('Test Valid Email'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    String title,
    Color color,
    String subtitle,
    List<String> points,
  ) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(subtitle, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...points.map(
              (point) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: Text(point)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard(
    String title,
    String example,
    String solution,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 4),
            Text('Example: $example'),
            const SizedBox(height: 4),
            Text(
              'Solution: $solution',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
