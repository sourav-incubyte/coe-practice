import 'package:flutter/material.dart';

// EXERCISE 1: BLoC vs Provider vs Riverpod Comparison
// Focus on understanding when to use each approach

class ComparisonExerciseApp extends StatelessWidget {
  const ComparisonExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management Comparison',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ComparisonScreen(),
    );
  }
}

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1: Provider vs BLoC vs Riverpod'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'State Management Comparison',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildComparisonTable(),
            const SizedBox(height: 30),
            _buildDecisionMatrix(),
            const SizedBox(height: 30),
            _buildScenarioCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonTable() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Comparison Table',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTableRow(
              'Feature',
              'Provider',
              'BLoC',
              'Riverpod',
              isHeader: true,
            ),
            _buildTableRow(
              'Core Logic',
              'ChangeNotifier',
              'Streams/Events',
              'Providers',
            ),
            _buildTableRow('Complexity', 'Low', 'High', 'Medium'),
            _buildTableRow(
              'Dependency',
              'BuildContext',
              'BuildContext',
              'No Context',
            ),
            _buildTableRow('Predictability', 'Medium', 'Very High', 'High'),
            _buildTableRow(
              'Best For',
              'Small/Medium',
              'Enterprise',
              'Modern Apps',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(
    String feature,
    String provider,
    String bloc,
    String riverpod, {
    bool isHeader = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              feature,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                fontSize: isHeader ? 14 : 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              provider,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              bloc,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              riverpod,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecisionMatrix() {
    return Card(
      color: Colors.amber.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Decision Matrix',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDecisionItem(
              'Simple state / Small team',
              'Provider',
              Colors.green,
            ),
            _buildDecisionItem(
              'Complex logic / Strict flow / Large team',
              'BLoC',
              Colors.blue,
            ),
            _buildDecisionItem(
              'Testability / No-context access / Modern DX',
              'Riverpod',
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecisionItem(String scenario, String solution, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(Icons.arrow_forward, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(scenario, style: const TextStyle(fontSize: 14))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              solution,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Practice Scenarios',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildScenarioCard(
          'Counter App',
          'Simple state that needs to be shared across a few widgets',
          'Provider',
          Colors.green,
        ),
        _buildScenarioCard(
          'E-commerce Cart',
          'Complex state with multiple events (add, remove, update)',
          'BLoC',
          Colors.blue,
        ),
        _buildScenarioCard(
          'User Profile',
          'State that needs to be accessed outside widget tree',
          'Riverpod',
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildScenarioCard(
    String title,
    String description,
    String recommended,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: const Icon(Icons.assignment, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            recommended,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
