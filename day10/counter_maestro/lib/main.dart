import 'package:flutter/material.dart';

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

// Counter Screen
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('You have pushed the button this many times:'),
          Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                key: const Key('Decrement'),
                onPressed: _decrementCounter,
                child: const Text('Decrement'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                key: const Key('Increment'),
                onPressed: _incrementCounter,
                child: const Text('Increment'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Input Screen
class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _displayText = '';

  void _submitForm() {
    print('Submit button pressed');
    print('Name: ${_nameController.text}');
    print('Email: ${_emailController.text}');
    setState(() {
      _displayText =
          'Name: ${_nameController.text}, Email: ${_emailController.text}';
      print('Display text set to: $_displayText');
    });
  }

  void _clearForm() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _displayText = '';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Input Form Test',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Semantics(
            identifier: 'name_field',
            label: 'Name',
            textField: true,
            child: TextField(
              key: const Key('name_field'),
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Semantics(
            identifier: 'email_field',
            label: 'Email',
            textField: true,
            child: TextField(
              key: const Key('email_field'),
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                key: const Key('submit_button'),
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                key: const Key('clear_button'),
                onPressed: _clearForm,
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            _displayText.isNotEmpty ? _displayText : 'No result yet',
            key: const Key('result_text'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Scroll Screen
class ScrollScreen extends StatelessWidget {
  const ScrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 50,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: SizedBox(
            height: 100,
            child: Semantics(
              label: 'Item ${index + 1}',
              child: ListTile(
                title: Text('Item ${index + 1}'),
                subtitle: Text('This is item number ${index + 1}'),
                leading: CircleAvatar(child: Text('${index + 1}')),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Swipe Screen
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
