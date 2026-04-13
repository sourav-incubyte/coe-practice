import 'package:flutter/material.dart';

// EXERCISE 3: Result Types and Functional Error Handling
// PROBLEM: Try-catch can lead to "Pyramid of Doom" and forgotten error handling
// TASK: Implement Result/Either pattern for functional error handling

// ===== RESULT TYPE IMPLEMENTATION =====
// A simple Result type that can be either Success or Failure
sealed class Result<T> {
  const Result();

  factory Result.success(T data) => Success<T>(data);
  factory Result.failure(String message, {String? code}) =>
      Failure<T>(message, code: code);
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final String message;
  final String? code;
  const Failure(this.message, {this.code});
}

// ===== DOMAIN-SPECIFIC FAILURES =====
sealed class AppFailure {
  final String message;
  final String code;

  AppFailure(this.message, this.code);

  @override
  String toString() => '$code: $message';
}

class NetworkFailure extends AppFailure {
  NetworkFailure([String message = 'Network error'])
    : super(message, 'NETWORK_ERROR');
}

class ValidationFailure extends AppFailure {
  ValidationFailure([String message = 'Validation failed'])
    : super(message, 'VALIDATION_ERROR');
}

class AuthFailure extends AppFailure {
  AuthFailure([String message = 'Authentication failed'])
    : super(message, 'AUTH_ERROR');
}

class ServerFailure extends AppFailure {
  ServerFailure([String message = 'Server error'])
    : super(message, 'SERVER_ERROR');
}

// ===== FUNCTIONAL ERROR HANDLING EXAMPLES =====

// BEFORE: Try-catch pyramid
class UserRepositoryBad {
  Future<String> getUserEmail(String userId) async {
    try {
      final user = await _fetchUser(userId);
      try {
        final email = await _fetchEmail(user);
        return email;
      } catch (e) {
        throw Exception('Failed to fetch email');
      }
    } catch (e) {
      throw Exception('Failed to fetch user');
    }
  }

  Future<String> _fetchUser(String userId) async => 'user123';
  Future<String> _fetchEmail(String user) async => 'user@example.com';
}

// AFTER: Functional error handling with Result
class UserRepositoryGood {
  Future<Result<String>> getUserEmail(String userId) async {
    final userResult = await _fetchUser(userId);

    if (userResult is Failure<String>) {
      return Result.failure(userResult.message, code: userResult.code);
    }

    final user = (userResult as Success<String>).data;
    final emailResult = await _fetchEmail(user);

    if (emailResult is Failure<String>) {
      return Result.failure(emailResult.message, code: emailResult.code);
    }

    return Result.success((emailResult as Success<String>).data);
  }

  Future<Result<String>> _fetchUser(String userId) async {
    if (userId.isEmpty) {
      return Result.failure('User ID cannot be empty', code: 'INVALID_ID');
    }
    return Result.success('user123');
  }

  Future<Result<String>> _fetchEmail(String user) async {
    if (user.isEmpty) {
      return Result.failure('User not found', code: 'USER_NOT_FOUND');
    }
    return Result.success('user@example.com');
  }
}

// ===== EXTENSION METHODS FOR RESULT =====
extension ResultExtension<T> on Result<T> {
  R fold<R>(
    R Function(Failure<T>) onFailure,
    R Function(Success<T>) onSuccess,
  ) {
    return switch (this) {
      Success() => onSuccess(this as Success<T>),
      Failure() => onFailure(this as Failure<T>),
    };
  }

  T getOrElse(T defaultValue) {
    return fold((failure) => defaultValue, (success) => success.data);
  }

  T? getOrNull() {
    return fold((failure) => null, (success) => success.data);
  }

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;
}

// ===== DEMO APP =====
class ResultTypesExerciseApp extends StatelessWidget {
  const ResultTypesExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Result Types Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const ResultTypesScreen(),
    );
  }
}

class ResultTypesScreen extends StatefulWidget {
  const ResultTypesScreen({super.key});

  @override
  State<ResultTypesScreen> createState() => _ResultTypesScreenState();
}

class _ResultTypesScreenState extends State<ResultTypesScreen> {
  final _userIdController = TextEditingController();
  final _userRepository = UserRepositoryGood();

  String _lastResult = '';
  bool _isLoading = false;

  Future<void> _testResultType() async {
    setState(() {
      _isLoading = true;
      _lastResult = '';
    });

    final result = await _userRepository.getUserEmail(_userIdController.text);

    setState(() {
      _isLoading = false;
      _lastResult = result.fold(
        (failure) => '❌ Error: ${failure.message} (${failure.code})',
        (success) => '✅ Success: ${success.data}',
      );
    });
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3: Result Types'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Result Types & Functional Error Handling',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildComparisonCard('BEFORE: Try-Catch Pyramid', [
              'try {',
              '  try {',
              '    try {',
              '      // Deep nesting',
              '    } catch (e) {',
              '      // Error handling',
              '    }',
              '  } catch (e) {',
              '    // More error handling',
              '  }',
              '} catch (e) {',
              '  // Even more error handling',
              '}',
            ], Colors.red),
            const SizedBox(height: 20),
            _buildComparisonCard('AFTER: Functional Error Handling', [
              'final result = await operation();',
              'result.fold(',
              '  (failure) => handleError(failure),',
              '  (success) => handleSuccess(success),',
              ');',
            ], Colors.green),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Benefits of Result Types:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildBenefitCard(
              'Forces Error Handling',
              'Compiler requires handling both success and failure',
            ),
            _buildBenefitCard('No Pyramids', 'Flat structure, no deep nesting'),
            _buildBenefitCard('Type Safety', 'Compile-time error checking'),
            _buildBenefitCard('Composable', 'Easy to chain operations'),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Try It Out:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(
                labelText: 'User ID',
                border: OutlineInputBorder(),
                hintText: 'Enter empty string to trigger error',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _testResultType,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Test Result Type'),
            ),
            const SizedBox(height: 20),
            if (_lastResult.isNotEmpty)
              Card(
                color: _lastResult.contains('Success')
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _lastResult,
                    style: TextStyle(
                      color: _lastResult.contains('Success')
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Result Type API:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildApiCard('Result.success(data)', 'Create a successful result'),
            _buildApiCard('Result.failure(message)', 'Create a failed result'),
            _buildApiCard(
              'result.fold(onError, onSuccess)',
              'Handle both cases',
            ),
            _buildApiCard('result.getOrElse(default)', 'Get data or default'),
            _buildApiCard('result.isSuccess', 'Check if successful'),
            _buildApiCard('result.isFailure', 'Check if failed'),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonCard(String title, List<String> code, Color color) {
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
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: code
                    .map(
                      (line) => Text(
                        line,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
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

  Widget _buildApiCard(String method, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                method,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(description)),
          ],
        ),
      ),
    );
  }
}
