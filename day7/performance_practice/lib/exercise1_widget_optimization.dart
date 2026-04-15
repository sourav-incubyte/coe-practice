import 'package:flutter/material.dart';

// EXERCISE 1: Widget Rebuild Optimization
// Demonstrates const constructors and keys

// Tracks how many times each widget builds
int constBuildCount = 0;
int nonConstBuildCount = 0;

class WidgetOptimizationExerciseApp extends StatelessWidget {
  const WidgetOptimizationExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Optimization Exercise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const WidgetOptimizationScreen(),
    );
  }
}

class WidgetOptimizationScreen extends StatefulWidget {
  const WidgetOptimizationScreen({super.key});

  @override
  State<WidgetOptimizationScreen> createState() => _WidgetOptimizationScreenState();
}

class _WidgetOptimizationScreenState extends State<WidgetOptimizationScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Exercise 1: Widget Optimization'),
        backgroundColor: const Color(0xFF5248C8),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Counter display
            Card(
              elevation: 0,
              color: const Color(0xFFEEEDFE),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 24),
                child: Column(children: [
                  const Text('Parent rebuild count',
                      style: TextStyle(
                          fontSize: 13, color: Color(0xFF534AB7))),
                  const SizedBox(height: 4),
                  Text('$_counter',
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3C3489))),
                  const SizedBox(height: 4),
                  const Text(
                      'Press the button → triggers setState on this page',
                      style: TextStyle(
                          fontSize: 12, color: Color(0xFF534AB7))),
                ]),
              ),
            ),

            const SizedBox(height: 24),

            // Two boxes side by side
            Row(
              children: [
                // CONST widget — will NOT rebuild
                Expanded(
                  child: _BuildCard(
                    label: 'const widget',
                    sublabel: 'ConstBox()',
                    useConst: true,
                  ),
                ),
                const SizedBox(width: 12),
                // NON-CONST widget — will rebuild every time
                Expanded(
                  child: _BuildCard(
                    label: 'non-const widget',
                    sublabel: 'NonConstBox()',
                    useConst: false,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Explanation card
            const Card(
              elevation: 0,
              color: Color(0xFFE1F5EE),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Why?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F6E56))),
                    SizedBox(height: 6),
                    Text(
                      'Flutter caches const widgets at compile-time. '
                      'When the parent calls setState(), Flutter\'s element '
                      'tree skips any subtree whose root is a const widget — '
                      'it is the exact same object in memory, so no diff is needed.',
                      style: TextStyle(
                          fontSize: 13, color: Color(0xFF085041)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF5248C8),
        foregroundColor: Colors.white,
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
        label: const Text('Trigger setState'),
        icon: const Icon(Icons.refresh),
      ),
    );
  }
}

// Wrapper that chooses which child to embed
class _BuildCard extends StatelessWidget {
  final String label;
  final String sublabel;
  final bool useConst;

  const _BuildCard(
      {required this.label,
      required this.sublabel,
      required this.useConst});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: useConst
                ? const Color(0xFF5248C8)
                : const Color(0xFFD85A30),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ),
        const SizedBox(height: 8),
        useConst ? const ConstBox() : NonConstBox(),
      ],
    );
  }
}

// CONST box — built ONCE, Flutter never calls build() again
class ConstBox extends StatelessWidget {
  const ConstBox({super.key});

  @override
  Widget build(BuildContext context) {
    constBuildCount++; // increments only once
    return _BoxFrame(
      color: const Color(0xFFEEEDFE),
      borderColor: const Color(0xFF7F77DD),
      textColor: const Color(0xFF3C3489),
      buildCount: constBuildCount,
      icon: Icons.lock_outline,
    );
  }
}

// NON-CONST box — rebuilt on every parent setState
class NonConstBox extends StatelessWidget {
  // ← no const constructor
  @override
  Widget build(BuildContext context) {
    nonConstBuildCount++; // increments on every parent rebuild
    return _BoxFrame(
      color: const Color(0xFFFAECE7),
      borderColor: const Color(0xFFD85A30),
      textColor: const Color(0xFF993C1D),
      buildCount: nonConstBuildCount,
      icon: Icons.refresh,
    );
  }
}

// Reusable frame widget
class _BoxFrame extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final Color textColor;
  final int buildCount;
  final IconData icon;

  const _BoxFrame({
    required this.color,
    required this.borderColor,
    required this.textColor,
    required this.buildCount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        Icon(icon, color: borderColor, size: 28),
        const SizedBox(height: 8),
        Text('build() called',
            style: TextStyle(fontSize: 12, color: textColor)),
        const SizedBox(height: 4),
        Text('$buildCount ×',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: textColor)),
      ]),
    );
  }
}
