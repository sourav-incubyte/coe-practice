import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

// Import all exercise files
import 'exercise1_provider_bloc_riverpod.dart';
import 'exercise2_multi_step_form.dart';
import 'exercise3_state_persistence.dart';
import 'exercise4_clean_architecture.dart';
import 'exercise5_hydrated_bloc.dart';

Future<void> main() async {
  // 1. Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Hydrated Storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(const ExerciseSelectorApp());
}

// Exercise selector app
class ExerciseSelectorApp extends StatelessWidget {
  const ExerciseSelectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management Patterns',
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
        title: const Text('State Management Patterns & Architecture'),
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
            const ComparisonExerciseApp(),
            '1',
            'Provider vs BLoC vs Riverpod',
            'Compare state management approaches',
            Colors.blue,
          ),
          _buildExerciseCard(
            context,
            const MultiStepFormExerciseApp(),
            '2',
            'Multi-Step Form',
            'State management for complex forms',
            Colors.teal,
          ),
          _buildExerciseCard(
            context,
            const StatePersistenceExerciseApp(),
            '3',
            'State Persistence',
            'Persist state across app restarts',
            Colors.orange,
          ),
          _buildExerciseCard(
            context,
            const CleanArchitectureExerciseApp(),
            '4',
            'Clean Architecture',
            'Separate presentation, domain, and data layers',
            Colors.purple,
          ),
          _buildExerciseCard(
            context,
            const HydratedBlocExerciseApp(),
            '5',
            'Hydrated BLoC',
            'Automatic state persistence with BLoC',
            Colors.deepPurple,
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
