import 'package:flutter/material.dart';

// EXERCISE 4: Lazy Loading and Pagination Patterns
// Demonstrates infinite scroll and pagination

class LazyLoadingExerciseApp extends StatelessWidget {
  const LazyLoadingExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lazy Loading Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const LazyLoadingScreen(),
    );
  }
}

class LazyLoadingScreen extends StatefulWidget {
  const LazyLoadingScreen({super.key});

  @override
  State<LazyLoadingScreen> createState() => _LazyLoadingScreenState();
}

class _LazyLoadingScreenState extends State<LazyLoadingScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<String> _items = List.generate(20, (index) => 'Item ${index + 1}');
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      final currentLength = _items.length;
      for (int i = 0; i < 10; i++) {
        _items.add('Item ${currentLength + i + 1}');
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4: Lazy Loading'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.orange.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lazy Loading Pattern',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Total items: ${_items.length}'),
                const SizedBox(height: 8),
                const Text('Scroll to bottom to load more'),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _items.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _items.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(_items[index]),
                  trailing: const Icon(Icons.arrow_forward),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _items.clear();
            _items.addAll(List.generate(20, (index) => 'Item ${index + 1}'));
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
