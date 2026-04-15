import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// EXERCISE 5: Hydrated BLoC for Automatic State Persistence
// Demonstrates automatic state persistence across app restarts
//
// HydratedBloc extends Bloc to automatically persist and restore state
// from local storage (JSON) without manual save/load logic.

// --- Events ---
// Define events that can change the state
abstract class CounterEvent {}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

// --- Hydrated BLoC ---
// CounterBloc extends HydratedBloc instead of regular Bloc
// This adds automatic state persistence capabilities
class CounterBloc extends HydratedBloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    // Initial state is 0
    // Register event handlers
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }

  // fromJson is called automatically when the app starts
  // It restores the state from local storage
  @override
  int? fromJson(Map<String, dynamic> json) {
    return json['value'] as int?;
  }

  // toJson is called automatically every time the state changes
  // It saves the state to local storage
  @override
  Map<String, dynamic>? toJson(int state) {
    return {'value': state};
  }
}

// --- UI ---
class HydratedBlocExerciseApp extends StatelessWidget {
  const HydratedBlocExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider provides the CounterBloc to the widget tree
    // The bloc will automatically restore its state when created
    return BlocProvider(create: (_) => CounterBloc(), child: CounterApp());
  }
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5: Hydrated BLoC'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        // BlocBuilder rebuilds when the CounterBloc state changes
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, state) {
            return Text('Count: $state', style: const TextStyle(fontSize: 30));
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Increment button
          FloatingActionButton(
            onPressed: () => context.read<CounterBloc>().add(Increment()),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          // Decrement button
          FloatingActionButton(
            onPressed: () => context.read<CounterBloc>().add(Decrement()),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
