import 'package:flutter/material.dart';

// Import all exercise files
import 'exercise1_exception_vs_error.dart';
import 'exercise2_custom_exceptions.dart';
import 'exercise3_result_types.dart';
import 'exercise4_async_error_handling.dart';
import 'exercise5_global_error_handling.dart';
import 'exercise6_error_boundary.dart';

void main() {
  runApp(const ExerciseSelectorApp());
}

// Exercise selector app
class ExerciseSelectorApp extends StatelessWidget {
  const ExerciseSelectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error Handling Practice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ExerciseSelectorScreen(),
    );
  }
}

class ExerciseSelectorScreen extends StatelessWidget {
  const ExerciseSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Handling Patterns & Custom Exceptions'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Choose an exercise to run:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildExerciseCard(
            context,
            const ExceptionVsErrorExerciseApp(),
            '1',
            'Exception vs Error',
            'Understand when to use Exception vs Error in Dart',
            Colors.red,
          ),
          _buildExerciseCard(
            context,
            const CustomExceptionsExerciseApp(),
            '2',
            'Custom Exception Hierarchy',
            'Create domain-specific exception types',
            Colors.purple,
          ),
          _buildExerciseCard(
            context,
            const ResultTypesExerciseApp(),
            '3',
            'Result Types',
            'Functional error handling with Either pattern',
            Colors.orange,
          ),
          _buildExerciseCard(
            context,
            const AsyncErrorHandlingExerciseApp(),
            '4',
            'Async Error Handling',
            'Handle errors in async code and streams',
            Colors.teal,
          ),
          _buildExerciseCard(
            context,
            const GlobalErrorHandlingExerciseApp(),
            '5',
            'Global Error Handling',
            'Implement global error catchers',
            Colors.red,
          ),
          _buildExerciseCard(
            context,
            const ErrorBoundaryExerciseApp(),
            '6',
            'Error Boundary Widgets',
            'Isolate errors with error boundaries',
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(
    BuildContext context,
    Widget exerciseApp,
    String exercise,
    String title,
    String description,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(exercise, style: const TextStyle(color: Colors.white)),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => exerciseApp),
          );
        },
      ),
    );
  }
}
