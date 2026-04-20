import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _displayText = '';

  void _submitForm() {
    print('Submit button pressed');
    print('Name: ${_nameController.text}');
    print('Email: ${_emailController.text}');
    setState(() {
      _displayText =
          'Name: ${_nameController.text}, Email: ${_emailController.text}';
      print('Display text set to: $_displayText');
    });
  }

  void _clearForm() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _displayText = '';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Input Form Test',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Semantics(
            identifier: 'name_field',
            label: 'Name',
            textField: true,
            child: TextField(
              key: const Key('name_field'),
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Semantics(
            identifier: 'email_field',
            label: 'Email',
            textField: true,
            child: TextField(
              key: const Key('email_field'),
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                key: const Key('submit_button'),
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                key: const Key('clear_button'),
                onPressed: _clearForm,
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            _displayText.isNotEmpty ? _displayText : 'No result yet',
            key: const Key('result_text'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
