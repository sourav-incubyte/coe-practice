import 'package:flutter/material.dart';

// EXERCISE 1: Meaningful Naming
// PROBLEM: Poor naming makes code hard to understand
// TASK: Refactor to use meaningful names

// ===== POOR NAMING (Before) =====
class W1 extends StatelessWidget {
  final String n;
  final int a;
  final bool i;

  const W1({required this.n, required this.a, required this.i});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(n),
          if (i) Text('$a'),
        ],
      ),
    );
  }

  void m() {
    if (a > 10) {
      print('big');
    }
  }
}

// ===== GOOD NAMING (After) =====
class UserProfileCard extends StatelessWidget {
  final String userName;
  final int userAge;
  final bool isOnline;

  const UserProfileCard({
    required this.userName,
    required this.userAge,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isOnline)
            Text(
              '$userAge years old',
              style: TextStyle(
                color: Colors.green[700],
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }

  void displayAgeMessage() {
    if (userAge > 10) {
      print('User is an adult');
    }
  }
}

// ===== DEMO APP =====
class NamingExerciseApp extends StatelessWidget {
  const NamingExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naming Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const NamingExerciseScreen(),
    );
  }
}

class NamingExerciseScreen extends StatelessWidget {
  const NamingExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1: Meaningful Naming'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Poor Naming vs Good Naming',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text(
                'POOR: W1, n, a, i, m()',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              const SizedBox(height: 10),
              const Text(
                'GOOD: UserProfileCard, userName, userAge, isOnline, displayAgeMessage()',
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
              const SizedBox(height: 40),
              const Text(
                'Example Card:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              UserProfileCard(
                userName: 'John Doe',
                userAge: 25,
                isOnline: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
