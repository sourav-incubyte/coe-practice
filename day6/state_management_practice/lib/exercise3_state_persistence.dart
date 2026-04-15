import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// EXERCISE 3: State Persistence Basics
// Demonstrates how to persist state across app restarts

class StatePersistenceExerciseApp extends StatelessWidget {
  const StatePersistenceExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Persistence Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const StatePersistenceScreen(),
    );
  }
}

class StatePersistenceScreen extends StatefulWidget {
  const StatePersistenceScreen({super.key});

  @override
  State<StatePersistenceScreen> createState() => _StatePersistenceScreenState();
}

class _StatePersistenceScreenState extends State<StatePersistenceScreen> {
  final _nameController = TextEditingController();
  final _countController = TextEditingController();

  String _savedName = '';
  int _savedCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    setState(() => _isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedName = prefs.getString('name') ?? '';
      _savedCount = prefs.getInt('count') ?? 0;
      _nameController.text = _savedName;
      _countController.text = _savedCount.toString();
      _isLoading = false;
    });
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setInt('count', int.tryParse(_countController.text) ?? 0);
    setState(() {
      _savedName = _nameController.text;
      _savedCount = int.tryParse(_countController.text) ?? 0;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('State saved!')));
  }

  Future<void> _clearState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      _savedName = '';
      _savedCount = 0;
      _nameController.clear();
      _countController.clear();
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('State cleared!')));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3: State Persistence'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'State Persistence with SharedPreferences',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Colors.orange.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '💡 Key Concept',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Persist state to local storage so it survives app restarts.',
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Workflow:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text('• fromJson → Restore on app start'),
                          const Text('• toJson → Save on every change'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Current State:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Name: $_savedName'),
                  Text('Count: $_savedCount'),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    'Edit State:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _countController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Count',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _saveState,
                          child: const Text('Save State'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _clearState,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Clear State'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    'Persistence Strategies:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildStrategyCard(
                    'SharedPreferences',
                    'Simple key-value storage for small data',
                    Colors.green,
                  ),
                  _buildStrategyCard(
                    'Hive',
                    'Fast NoSQL database for complex objects',
                    Colors.blue,
                  ),
                  _buildStrategyCard(
                    'Sqflite',
                    'Full SQL database for relational data',
                    Colors.purple,
                  ),
                  _buildStrategyCard(
                    'Hydrated BLoC',
                    'Automatic BLoC state persistence',
                    Colors.orange,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStrategyCard(String title, String description, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: const Icon(Icons.storage, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}
