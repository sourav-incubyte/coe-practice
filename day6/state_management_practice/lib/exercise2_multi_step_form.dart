import 'package:flutter/material.dart';

// EXERCISE 2: Simple Multi-Step Form with State Management
// Demonstrates how to manage state across multiple form steps

class MultiStepFormExerciseApp extends StatelessWidget {
  const MultiStepFormExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Step Form Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MultiStepFormScreen(),
    );
  }
}

class MultiStepFormScreen extends StatefulWidget {
  const MultiStepFormScreen({super.key});

  @override
  State<MultiStepFormScreen> createState() => _MultiStepFormScreenState();
}

class _MultiStepFormScreenState extends State<MultiStepFormScreen> {
  // Form state model
  final _formModel = FormModel();

  int _currentStep = 0;

  // Step controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      // Save current step data
      if (_currentStep == 0) {
        _formModel.name = _nameController.text;
        _formModel.email = _emailController.text;
      } else if (_currentStep == 1) {
        _formModel.address = _addressController.text;
      }

      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _submitForm() {
    // Save final step data
    _formModel.address = _addressController.text;

    // Show summary
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Form Submitted'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${_formModel.name}'),
            Text('Email: ${_formModel.email}'),
            Text('Address: ${_formModel.address}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentStep = 0;
                _nameController.clear();
                _emailController.clear();
                _addressController.clear();
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2: Multi-Step Form'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Progress indicator
            _buildProgressIndicator(),
            const SizedBox(height: 20),
            // Form content
            Expanded(child: _buildCurrentStep()),
            // Navigation buttons
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      children: List.generate(3, (index) {
        final isActive = index == _currentStep;
        final isCompleted = index < _currentStep;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
            height: 4,
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.teal
                  : isCompleted
                  ? Colors.teal.withOpacity(0.5)
                  : Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildStep1();
      case 1:
        return _buildStep2();
      case 2:
        return _buildStep3();
      default:
        return const SizedBox();
    }
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 1: Personal Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          color: Colors.blue.withOpacity(0.1),
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              '💡 Tip: State is stored in a single FormModel object that persists across steps',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 2: Address Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _addressController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Address',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          color: Colors.green.withOpacity(0.1),
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              '💡 Tip: Validate the entire model at the final step, not each step individually',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 3: Review & Submit',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Review your information:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text('Name: ${_nameController.text}'),
                const SizedBox(height: 8),
                Text('Email: ${_emailController.text}'),
                const SizedBox(height: 8),
                Text('Address: ${_addressController.text}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          color: Colors.orange.withOpacity(0.1),
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              '💡 Tip: Update the model incrementally, validate at the end',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_currentStep > 0)
          ElevatedButton(
            onPressed: _previousStep,
            child: const Text('Previous'),
          )
        else
          const SizedBox(),
        if (_currentStep < 2)
          ElevatedButton(onPressed: _nextStep, child: const Text('Next'))
        else
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: const Text('Submit'),
          ),
      ],
    );
  }
}

// Simple form model to persist state across steps
class FormModel {
  String name = '';
  String email = '';
  String address = '';
}
