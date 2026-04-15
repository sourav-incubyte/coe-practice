import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// EXERCISE 3: Image Optimization and Caching
// Demonstrates efficient image loading and caching

class ImageOptimizationExerciseApp extends StatelessWidget {
  const ImageOptimizationExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Optimization Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const ImageOptimizationScreen(),
    );
  }
}

class ImageOptimizationScreen extends StatefulWidget {
  const ImageOptimizationScreen({super.key});

  @override
  State<ImageOptimizationScreen> createState() =>
      _ImageOptimizationScreenState();
}

class _ImageOptimizationScreenState extends State<ImageOptimizationScreen> {
  int _loadCount = 0;

  void _incrementLoadCount() {
    setState(() {
      _loadCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exercise 3: Image Optimization'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Bad (No Cache)'),
              Tab(text: 'Good (Cached)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _BadImageTab(onLoad: _incrementLoadCount),
            _GoodImageTab(onLoad: _incrementLoadCount),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey.withOpacity(0.1),
          child: Text(
            'Image loads: $_loadCount',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// BAD: Image without caching - reloads every time
class _BadImageTab extends StatelessWidget {
  final VoidCallback onLoad;

  const _BadImageTab({required this.onLoad});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.red.withOpacity(0.1),
          child: const Text(
            '❌ Bad: Network image without caching',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://via.placeholder.com/200x300',
                  width: 200,
                  height: 300,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onLoad,
                  child: const Text('Reload Image'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// GOOD: Image with caching - loads once, reused
class _GoodImageTab extends StatelessWidget {
  final VoidCallback onLoad;

  const _GoodImageTab({required this.onLoad});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.green.withOpacity(0.1),
          child: const Text(
            '✅ Good: Cached network image',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: 'https://via.placeholder.com/200x300',
                  width: 200,
                  height: 300,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onLoad,
                  child: const Text('Reload Image'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
