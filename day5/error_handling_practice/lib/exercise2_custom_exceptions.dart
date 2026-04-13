import 'package:flutter/material.dart';

// EXERCISE 2: Custom Exception Hierarchy
// PROBLEM: Using generic Exception instead of specific custom exceptions
// TASK: Create a proper exception hierarchy for domain-specific errors

// ===== BASE EXCEPTION =====
// Create a base exception for your domain
abstract class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});

  @override
  String toString() =>
      '${runtimeType}: $message${code != null ? ' (code: $code)' : ''}';
}

// ===== AUTHENTICATION EXCEPTIONS =====
class AuthException extends AppException {
  AuthException(super.message, {super.code});
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException()
    : super('Invalid username or password', code: 'INVALID_CREDENTIALS');
}

class AccountLockedException extends AuthException {
  AccountLockedException() : super('Account is locked', code: 'ACCOUNT_LOCKED');
}

class SessionExpiredException extends AuthException {
  SessionExpiredException()
    : super('Session has expired', code: 'SESSION_EXPIRED');
}

// ===== VALIDATION EXCEPTIONS =====
class ValidationException extends AppException {
  final String field;

  ValidationException(this.field, super.message, {super.code});

  @override
  String toString() =>
      'ValidationException on $field: $message${code != null ? ' (code: $code)' : ''}';
}

class EmailValidationException extends ValidationException {
  EmailValidationException()
    : super('email', 'Invalid email format', code: 'INVALID_EMAIL');
}

class PasswordValidationException extends ValidationException {
  PasswordValidationException()
    : super(
        'password',
        'Password must be at least 8 characters',
        code: 'WEAK_PASSWORD',
      );
}

class AgeValidationException extends ValidationException {
  AgeValidationException()
    : super('age', 'Must be at least 18 years old', code: 'UNDERAGE');
}

// ===== NETWORK EXCEPTIONS =====
class NetworkException extends AppException {
  NetworkException(super.message, {super.code});
}

class ConnectionException extends NetworkException {
  ConnectionException()
    : super('No internet connection', code: 'NO_CONNECTION');
}

class ServerException extends NetworkException {
  ServerException([String message = 'Server error'])
    : super(message, code: 'SERVER_ERROR');
}

class TimeoutException extends NetworkException {
  TimeoutException() : super('Request timed out', code: 'TIMEOUT');
}

// ===== DATA EXCEPTIONS =====
class DataException extends AppException {
  DataException(super.message, {super.code});
}

class NotFoundException extends DataException {
  NotFoundException(String resource)
    : super('$resource not found', code: 'NOT_FOUND');
}

class DuplicateException extends DataException {
  DuplicateException(String resource)
    : super('$resource already exists', code: 'DUPLICATE');
}

// ===== USAGE EXAMPLES =====
class AuthService {
  void login(String username, String password) {
    if (username.isEmpty || password.isEmpty) {
      throw InvalidCredentialsException();
    }
    if (username == 'locked') {
      throw AccountLockedException();
    }
    // Login logic here
  }
}

class ValidationService {
  void validateEmail(String email) {
    if (!email.contains('@')) {
      throw EmailValidationException();
    }
  }

  void validatePassword(String password) {
    if (password.length < 8) {
      throw PasswordValidationException();
    }
  }

  void validateAge(int age) {
    if (age < 18) {
      throw AgeValidationException();
    }
  }
}

// ===== DEMO APP =====
class CustomExceptionsExerciseApp extends StatelessWidget {
  const CustomExceptionsExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Exceptions Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const CustomExceptionsScreen(),
    );
  }
}

class CustomExceptionsScreen extends StatefulWidget {
  const CustomExceptionsScreen({super.key});

  @override
  State<CustomExceptionsScreen> createState() => _CustomExceptionsScreenState();
}

class _CustomExceptionsScreenState extends State<CustomExceptionsScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();
  final _authService = AuthService();
  final _validationService = ValidationService();

  String _lastError = '';

  void _handleAuth() {
    try {
      _authService.login(_emailController.text, _passwordController.text);
      setState(() => _lastError = 'Login successful!');
    } on AppException catch (e) {
      setState(() => _lastError = e.toString());
    }
  }

  void _handleValidation() {
    try {
      _validationService.validateEmail(_emailController.text);
      _validationService.validatePassword(_passwordController.text);
      final age = int.tryParse(_ageController.text) ?? 0;
      _validationService.validateAge(age);
      setState(() => _lastError = 'All validations passed!');
    } on AppException catch (e) {
      setState(() => _lastError = e.toString());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2: Custom Exception Hierarchy'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Custom Exception Hierarchy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Benefits of Custom Exceptions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildBenefitCard(
              'Type Safety',
              'Catch specific exceptions with type checking',
            ),
            _buildBenefitCard(
              'Domain Clarity',
              'Exceptions reflect your business domain',
            ),
            _buildBenefitCard(
              'Error Codes',
              'Include error codes for API responses',
            ),
            _buildBenefitCard(
              'Better Messages',
              'User-friendly error messages',
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Exception Hierarchy:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildHierarchyTree(),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Try It Out:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _handleAuth,
                    child: const Text('Test Auth'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _handleValidation,
                    child: const Text('Test Validation'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_lastError.isNotEmpty)
              Card(
                color: _lastError.contains('successful')
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _lastError,
                    style: TextStyle(
                      color: _lastError.contains('successful')
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHierarchyTree() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTreeNode('AppException (Base)', isRoot: true),
            _buildTreeNode('├── AuthException'),
            _buildTreeNode('│   ├── InvalidCredentialsException'),
            _buildTreeNode('│   ├── AccountLockedException'),
            _buildTreeNode('│   └── SessionExpiredException'),
            _buildTreeNode('├── ValidationException'),
            _buildTreeNode('│   ├── EmailValidationException'),
            _buildTreeNode('│   ├── PasswordValidationException'),
            _buildTreeNode('│   └── AgeValidationException'),
            _buildTreeNode('├── NetworkException'),
            _buildTreeNode('│   ├── ConnectionException'),
            _buildTreeNode('│   ├── ServerException'),
            _buildTreeNode('│   └── TimeoutException'),
            _buildTreeNode('└── DataException'),
            _buildTreeNode('    ├── NotFoundException'),
            _buildTreeNode('    └── DuplicateException'),
          ],
        ),
      ),
    );
  }

  Widget _buildTreeNode(String text, {bool isRoot = false}) {
    return Padding(
      padding: EdgeInsets.only(left: isRoot ? 0 : 16),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isRoot ? FontWeight.bold : FontWeight.normal,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}
