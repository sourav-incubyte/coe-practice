import 'package:flutter/material.dart';

// EXERCISE 4: Clean Architecture Separation
// Demonstrates how to separate presentation, domain, and data layers

// ===== DOMAIN LAYER (Business Logic) =====

// Entity - Plain data object
class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});
}

// Use Case - Business rule
class GetUserUseCase {
  final UserRepository _repository;

  GetUserUseCase(this._repository);

  Future<User> execute(String userId) async {
    // Business logic can go here (validation, transformations, etc.)
    final user = await _repository.getUser(userId);
    return user;
  }
}

// ===== DATA LAYER (Data Sources) =====

// Repository - Abstracts data source
abstract class UserRepository {
  Future<User> getUser(String userId);
}

// Implementation - Could be API or local DB
class MockUserRepository implements UserRepository {
  @override
  Future<User> getUser(String userId) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return User(id: userId, name: 'John Doe', email: 'john@example.com');
  }
}

// ===== PRESENTATION LAYER (UI) =====

class CleanArchitectureExerciseApp extends StatelessWidget {
  const CleanArchitectureExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const CleanArchitectureScreen(),
    );
  }
}

class CleanArchitectureScreen extends StatefulWidget {
  const CleanArchitectureScreen({super.key});

  @override
  State<CleanArchitectureScreen> createState() =>
      _CleanArchitectureScreenState();
}

class _CleanArchitectureScreenState extends State<CleanArchitectureScreen> {
  final _getUserUseCase = GetUserUseCase(MockUserRepository());

  User? _user;
  bool _isLoading = false;

  Future<void> _loadUser() async {
    setState(() => _isLoading = true);
    try {
      // Presentation layer calls Use Case (not Repository directly)
      final user = await _getUserUseCase.execute('123');
      setState(() => _user = user);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4: Clean Architecture'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Clean Architecture Layers',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildLayerCard(
              'Presentation Layer',
              'UI Widgets + State Management',
              'Handles user input and displays data',
              Colors.blue,
              ['Screens', 'Widgets', 'State Management (BLoC/Provider)'],
            ),
            _buildLayerCard(
              'Domain Layer',
              'Entities + Use Cases',
              'Contains business logic and rules',
              Colors.green,
              [
                'Entities (Plain objects)',
                'Use Cases (Business rules)',
                'Repository interfaces',
              ],
            ),
            _buildLayerCard(
              'Data Layer',
              'Repositories + Data Sources',
              'Handles data from API/Local DB',
              Colors.orange,
              [
                'Repository implementations',
                'Data Sources (API/Local DB)',
                'DTOs (Data Transfer Objects)',
              ],
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Repository Pattern Rule:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.red.withOpacity(0.1),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  '❌ State management should call a Repository, never a raw API client',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Try It:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _loadUser,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Load User'),
            ),
            const SizedBox(height: 20),
            if (_user != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${_user!.id}'),
                      Text('Name: ${_user!.name}'),
                      Text('Email: ${_user!.email}'),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Common Pitfalls:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildPitfallCard(
              'Logic in UI',
              'Putting if/else business logic inside build methods',
            ),
            _buildPitfallCard(
              'God Objects',
              'Creating one massive state object for the entire app',
            ),
            _buildPitfallCard(
              'Leaky Abstractions',
              'Passing API response models directly to UI',
            ),
            _buildPitfallCard(
              'Over-notifying',
              'Calling notifyListeners() when data hasn\'t changed',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLayerCard(
    String title,
    String subtitle,
    String description,
    Color color,
    List<String> items,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.layers, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 8),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Text('• $item'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPitfallCard(String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.warning, color: Colors.red),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}
