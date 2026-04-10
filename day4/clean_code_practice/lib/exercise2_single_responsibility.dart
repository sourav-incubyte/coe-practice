import 'package:flutter/material.dart';

// EXERCISE 2: Single Responsibility & Method Extraction
// PROBLEM: Long methods doing too many things
// TASK: Extract into focused functions

// ===== POOR DESIGN (Before) =====
class UserFormWidget extends StatefulWidget {
  const UserFormWidget({super.key});

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                if (value.length < 3) {
                  return 'Name must be at least 3 characters';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!value.contains('@')) {
                  return 'Invalid email format';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Age is required';
                }
                final age = int.tryParse(value);
                if (age == null || age < 18) {
                  return 'Must be at least 18';
                }
                return null;
              },
            ),
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      setState(() => _isLoading = true);
                      Future.delayed(const Duration(seconds: 2), () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = false;
                            _errorMessage = null;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('User saved!')),
                          );
                        } else {
                          setState(() {
                            _isLoading = false;
                            _errorMessage = 'Please fix errors';
                          });
                        }
                      });
                    },
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== GOOD DESIGN (After) =====
class CleanUserForm extends StatefulWidget {
  const CleanUserForm({super.key});

  @override
  State<CleanUserForm> createState() => _CleanUserFormState();
}

class _CleanUserFormState extends State<CleanUserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  // Single Responsibility: Each method does one thing
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    final age = int.tryParse(value);
    if (age == null || age < 18) {
      return 'Must be at least 18';
    }
    return null;
  }

  Future<void> handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _errorMessage = 'Please fix errors');
      return;
    }

    setState(() => _isLoading = true);
    setState(() => _errorMessage = null);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);
    showSuccessMessage();
  }

  void showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Form'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildNameField(),
              _buildEmailField(),
              _buildAgeField(),
              if (_errorMessage != null) _buildErrorMessage(),
              const SizedBox(height: 20),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(labelText: 'Name'),
      validator: validateName,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(labelText: 'Email'),
      validator: validateEmail,
    );
  }

  Widget _buildAgeField() {
    return TextFormField(
      controller: _ageController,
      decoration: const InputDecoration(labelText: 'Age'),
      keyboardType: TextInputType.number,
      validator: validateAge,
    );
  }

  Widget _buildErrorMessage() {
    return Text(
      _errorMessage!,
      style: const TextStyle(color: Colors.red),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : handleSubmit,
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text('Submit'),
    );
  }
}

// ===== DEMO APP =====
class SingleResponsibilityExerciseApp extends StatelessWidget {
  const SingleResponsibilityExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Single Responsibility Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const CleanUserForm(),
    );
  }
}
