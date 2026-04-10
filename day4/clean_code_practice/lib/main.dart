import 'package:flutter/material.dart';

// Import all exercise files
import 'exercise1_naming.dart';
import 'exercise2_single_responsibility.dart';
import 'exercise3_code_smells.dart';
import 'exercise4_self_documenting.dart';
import 'exercise5_dry_principle.dart';
import 'exercise6_guard_clauses.dart';

void main() {
  runApp(const ExerciseSelectorApp());
}

// Exercise selector app
class ExerciseSelectorApp extends StatelessWidget {
  const ExerciseSelectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Code Practice',
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
        title: const Text('Clean Code & Code Smell Identification'),
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
            const NamingExerciseApp(),
            '1',
            'Meaningful Naming',
            'Learn to use descriptive names for variables and widgets',
            Colors.blue,
          ),
          _buildExerciseCard(
            context,
            const SingleResponsibilityExerciseApp(),
            '2',
            'Single Responsibility',
            'Extract long methods into focused functions',
            Colors.green,
          ),
          _buildExerciseCard(
            context,
            const CodeSmellsExerciseApp(),
            '3',
            'Code Smells',
            'Identify and refactor god widgets & deep nesting',
            Colors.orange,
          ),
          _buildExerciseCard(
            context,
            const SelfDocumentingExerciseApp(),
            '4',
            'Self-Documenting Code',
            'Remove comments by improving code clarity',
            Colors.purple,
          ),
          _buildExerciseCard(
            context,
            const DryPrincipleExerciseApp(),
            '5',
            'DRY Principle',
            'Extract repeated patterns into reusable utilities',
            Colors.teal,
          ),
          _buildExerciseCard(
            context,
            const GuardClausesExerciseApp(),
            '6',
            'Guard Clauses',
            'Use early returns for better readability',
            Colors.indigo,
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
