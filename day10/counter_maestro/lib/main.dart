import 'package:flutter/material.dart';
import 'screens/counter_screen.dart';
import 'screens/input_screen.dart';
import 'screens/scroll_screen.dart';
import 'screens/swipe_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Maestro Test Demo'),
      ),
      body: Column(
        children: [
          // Navigation buttons at the top
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  key: const Key('Counter'),
                  onPressed: () => setState(() => _selectedIndex = 0),
                  child: const Text('Counter'),
                ),
                ElevatedButton(
                  key: const Key('Input'),
                  onPressed: () => setState(() => _selectedIndex = 1),
                  child: const Text('Input'),
                ),
                ElevatedButton(
                  key: const Key('Scroll'),
                  onPressed: () => setState(() => _selectedIndex = 2),
                  child: const Text('Scroll'),
                ),
                ElevatedButton(
                  key: const Key('Swipe'),
                  onPressed: () => setState(() => _selectedIndex = 3),
                  child: const Text('Swipe'),
                ),
              ],
            ),
          ),
          const Divider(),
          // Content area
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: const [
                CounterScreen(),
                InputScreen(),
                ScrollScreen(),
                SwipeScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
