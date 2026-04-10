import 'package:flutter/material.dart';

// EXERCISE 6: Guard Clauses & Early Returns
// PROBLEM: Deep nesting makes code hard to read
// TASK: Use guard clauses for early returns

// ===== DEEP NESTING (Before) =====
class BadValidation {
  String validateUser(String? name, int? age, String? email) {
    if (name != null) {
      if (name.isNotEmpty) {
        if (age != null) {
          if (age >= 18) {
            if (email != null) {
              if (email.contains('@')) {
                return 'Valid user';
              } else {
                return 'Invalid email';
              }
            } else {
              return 'Email is required';
            }
          } else {
            return 'Must be at least 18';
          }
        } else {
          return 'Age is required';
        }
      } else {
        return 'Name cannot be empty';
      }
    } else {
      return 'Name is required';
    }
  }

  Widget buildUserCard(String? name, bool? isOnline, String? avatarUrl) {
    if (name != null) {
      if (name.isNotEmpty) {
        if (isOnline != null) {
          if (isOnline) {
            if (avatarUrl != null) {
              if (avatarUrl.isNotEmpty) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(avatarUrl),
                    ),
                    title: Text(name),
                    trailing: const Icon(Icons.circle, color: Colors.green),
                  ),
                );
              } else {
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(name),
                    trailing: const Icon(Icons.circle, color: Colors.green),
                  ),
                );
              }
            } else {
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(name),
                  trailing: const Icon(Icons.circle, color: Colors.green),
                ),
              );
            }
          } else {
            return Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(name),
                trailing: const Icon(Icons.circle, color: Colors.grey),
              ),
            );
          }
        } else {
          return Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(name),
            ),
          );
        }
      } else {
        return const Card(child: ListTile(title: Text('Invalid user')));
      }
    } else {
      return const Card(child: ListTile(title: Text('Invalid user')));
    }
  }
}

// ===== GUARD CLAUSES (After) =====
class CleanValidation {
  String validateUser(String? name, int? age, String? email) {
    // Guard clauses - fail fast
    if (name == null) return 'Name is required';
    if (name.isEmpty) return 'Name cannot be empty';
    if (age == null) return 'Age is required';
    if (age < 18) return 'Must be at least 18';
    if (email == null) return 'Email is required';
    if (!email.contains('@')) return 'Invalid email';

    return 'Valid user';
  }

  Widget buildUserCard(String? name, bool? isOnline, String? avatarUrl) {
    // Guard clauses
    if (name == null || name.isEmpty) {
      return const Card(child: ListTile(title: Text('Invalid user')));
    }

    final onlineStatus = isOnline ?? false;
    final avatarWidget = avatarUrl?.isNotEmpty == true
        ? CircleAvatar(backgroundImage: NetworkImage(avatarUrl!))
        : const CircleAvatar(child: Icon(Icons.person));

    final statusIcon = onlineStatus
        ? const Icon(Icons.circle, color: Colors.green)
        : const Icon(Icons.circle, color: Colors.grey);

    return Card(
      child: ListTile(
        leading: avatarWidget,
        title: Text(name),
        trailing: statusIcon,
      ),
    );
  }
}

// ===== FLUTTER WIDGET EXAMPLE =====

// BEFORE: Deep nesting in build method
class BadFormScreen extends StatelessWidget {
  final String? username;
  final String? email;
  final bool isLoading;
  final String? errorMessage;

  const BadFormScreen({
    required this.username,
    required this.email,
    required this.isLoading,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (username != null) {
      if (username!.isNotEmpty) {
        if (email != null) {
          if (email!.isNotEmpty) {
            if (isLoading) {
              content = const CircularProgressIndicator();
            } else {
              if (errorMessage != null) {
                content = Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                );
              } else {
                content = ElevatedButton(
                  onPressed: () {},
                  child: const Text('Submit'),
                );
              }
            }
          } else {
            content = const Text('Email is required');
          }
        } else {
          content = const Text('Email is required');
        }
      } else {
        content = const Text('Username is required');
      }
    } else {
      content = const Text('Username is required');
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Bad Form')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [content],
        ),
      ),
    );
  }
}

// AFTER: Guard clauses for clean code
class CleanFormScreen extends StatelessWidget {
  final String? username;
  final String? email;
  final bool isLoading;
  final String? errorMessage;

  const CleanFormScreen({
    required this.username,
    required this.email,
    required this.isLoading,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clean Form')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (username == null || username!.isEmpty)
              const Text('Username is required')
            else if (email == null || email!.isEmpty)
              const Text('Email is required')
            else if (isLoading)
              const CircularProgressIndicator()
            else if (errorMessage != null)
              Text(errorMessage!, style: const TextStyle(color: Colors.red))
            else
              ElevatedButton(onPressed: () {}, child: const Text('Submit')),
          ],
        ),
      ),
    );
  }
}

// ===== DEMO APP =====
class GuardClausesExerciseApp extends StatelessWidget {
  const GuardClausesExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final validation = CleanValidation();

    return MaterialApp(
      title: 'Guard Clauses Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: GuardClausesScreen(validation: validation),
    );
  }
}

class GuardClausesScreen extends StatelessWidget {
  final CleanValidation validation;

  const GuardClausesScreen({super.key, required this.validation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 6: Guard Clauses'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Guard Clauses & Early Returns',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'BEFORE: Deep nesting',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 10),
            const Text(
              'if (condition) { if (condition) { if (condition) { ... } } }',
            ),
            const SizedBox(height: 20),
            const Text(
              'AFTER: Guard clauses',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            const SizedBox(height: 10),
            const Text('if (invalid) return;'),
            const Text('// Happy path code here'),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Validation Examples:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildValidationResult(
              'Valid user',
              validation.validateUser('John', 25, 'john@email.com'),
              Colors.green,
            ),
            const SizedBox(height: 10),
            _buildValidationResult(
              'Missing name',
              validation.validateUser(null, 25, 'john@email.com'),
              Colors.red,
            ),
            const SizedBox(height: 10),
            _buildValidationResult(
              'Too young',
              validation.validateUser('John', 16, 'john@email.com'),
              Colors.red,
            ),
            const SizedBox(height: 10),
            _buildValidationResult(
              'Invalid email',
              validation.validateUser('John', 25, 'invalid-email'),
              Colors.red,
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'User Card Examples:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            validation.buildUserCard('John Doe', true, null),
            const SizedBox(height: 10),
            validation.buildUserCard(
              'Jane Smith',
              false,
              'https://example.com/avatar.jpg',
            ),
            const SizedBox(height: 10),
            validation.buildUserCard('', true, null),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationResult(String label, String result, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            result,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
