import 'package:flutter/material.dart';

// EXERCISE 2: ListView Performance Comparison
// Demonstrates ListView.builder vs ListView for large lists

class ListviewPerformanceExerciseApp extends StatelessWidget {
  const ListviewPerformanceExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView Performance Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ListviewPerformanceScreen(),
    );
  }
}

class ListviewPerformanceScreen extends StatefulWidget {
  const ListviewPerformanceScreen({super.key});

  @override
  State<ListviewPerformanceScreen> createState() =>
      _ListviewPerformanceScreenState();
}

class _ListviewPerformanceScreenState extends State<ListviewPerformanceScreen> {
  // Generate 1000 items
  final List<String> _items = List.generate(
    1000,
    (index) => 'Item ${index + 1}',
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exercise 2: ListView Performance'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Bad ListView'),
              Tab(text: 'Good ListView.builder'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_BadListViewTab(), _GoodListViewTab()],
        ),
      ),
    );
  }
}

// BAD: Regular ListView - creates all widgets at once
class _BadListViewTab extends StatelessWidget {
  const _BadListViewTab();

  @override
  Widget build(BuildContext context) {
    final items = List.generate(1000, (index) => 'Item ${index + 1}');

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.red.withOpacity(0.1),
          child: const Text(
            '❌ Bad: Creates all 1000 widgets at once',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView(
            children: items
                .map(
                  (item) => ListTile(
                    title: Text(item),
                    leading: const Icon(Icons.list),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

// GOOD: ListView.builder - creates widgets on demand
class _GoodListViewTab extends StatelessWidget {
  const _GoodListViewTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.green.withOpacity(0.1),
          child: const Text(
            '✅ Good: Creates widgets only when visible',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: 1000,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item ${index + 1}'),
                leading: const Icon(Icons.list),
              );
            },
          ),
        ),
      ],
    );
  }
}
