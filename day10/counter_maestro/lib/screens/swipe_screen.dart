import 'package:flutter/material.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final List<String> _items = List.generate(5, (index) => 'Item ${index + 1}');
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Swipe to navigate items', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 40),
          Container(
            key: const Key('swipe_container'),
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.deepPurple[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                _items[_currentIndex],
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                key: const Key('prev_button'),
                onPressed: _currentIndex > 0
                    ? () => setState(() => _currentIndex--)
                    : null,
                child: const Text('Previous'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                key: const Key('next_button'),
                onPressed: _currentIndex < _items.length - 1
                    ? () => setState(() => _currentIndex++)
                    : null,
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
