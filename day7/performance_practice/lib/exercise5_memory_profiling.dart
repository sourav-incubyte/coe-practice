import 'dart:async';
import 'package:flutter/material.dart';

// EXERCISE 5: Memory Profiling Basics
// Demonstrates memory leaks and proper dispose patterns

// Shared log so both widgets write to the same list
final ValueNotifier<List<String>> eventLog = ValueNotifier([]);

void addLog(String msg) {
  final now = DateTime.now();
  final timestamp =
      '${now.second.toString().padLeft(2, '0')}.${now.millisecond.toString().padLeft(3, '0')}';
  eventLog.value = ['[$timestamp] $msg', ...eventLog.value.take(40)];
}

class MemoryProfilingExerciseApp extends StatelessWidget {
  const MemoryProfilingExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Profiling Exercise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const MemoryProfilingScreen(),
    );
  }
}

class MemoryProfilingScreen extends StatefulWidget {
  const MemoryProfilingScreen({super.key});

  @override
  State<MemoryProfilingScreen> createState() => _MemoryProfilingScreenState();
}

class _MemoryProfilingScreenState extends State<MemoryProfilingScreen> {
  bool _showLeaky = false;
  bool _showFixed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5: Memory Profiling'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions card
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'How to observe the leak:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '1. Press "Add Leaky Widget" → watch red ticks in log.\n'
                      '2. Press "Remove Leaky Widget" → red ticks KEEP coming! (leak)\n'
                      '3. Press "Add Fixed Widget" → watch green ticks.\n'
                      '4. Press "Remove Fixed Widget" → green ticks STOP. (correct)',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Control buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _showLeaky
                          ? Colors.red.shade100
                          : Colors.red.shade400,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => setState(() => _showLeaky = !_showLeaky),
                    icon: Icon(_showLeaky ? Icons.remove : Icons.add),
                    label: Text(
                      _showLeaky ? 'Remove Leaky Widget' : 'Add Leaky Widget',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _showFixed
                          ? Colors.green.shade100
                          : Colors.green.shade600,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => setState(() => _showFixed = !_showFixed),
                    icon: Icon(_showFixed ? Icons.remove : Icons.add),
                    label: Text(
                      _showFixed ? 'Remove Fixed Widget' : 'Add Fixed Widget',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Widget slots
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _showLeaky
                      ? const LeakyWidget()
                      : _EmptySlot(
                          label: 'Leaky widget slot',
                          color: Colors.red.shade100,
                        ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _showFixed
                      ? const FixedWidget()
                      : _EmptySlot(
                          label: 'Fixed widget slot',
                          color: Colors.green.shade100,
                        ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Log header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Event Log',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextButton.icon(
                  onPressed: () => eventLog.value = [],
                  icon: const Icon(Icons.clear_all, size: 16),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const Divider(height: 4),

            // Log list
            Expanded(
              child: ValueListenableBuilder<List<String>>(
                valueListenable: eventLog,
                builder: (_, entries, __) {
                  if (entries.isEmpty) {
                    return const Center(
                      child: Text(
                        'No events yet — add a widget above.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount: entries.length,
                    itemBuilder: (_, i) {
                      final e = entries[i];
                      final isLeaky = e.contains('LEAKY');
                      final isDispose = e.contains('disposed');
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Text(
                          e,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            color: isDispose
                                ? Colors.orange.shade800
                                : isLeaky
                                ? Colors.red.shade700
                                : Colors.green.shade700,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Empty slot placeholder
class _EmptySlot extends StatelessWidget {
  final String label;
  final Color color;
  const _EmptySlot({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ),
    );
  }
}

// LEAKY Widget - Timer.periodic is started in initState but NEVER cancelled.
// Even after this widget is removed from the tree, the timer keeps firing.
class LeakyWidget extends StatefulWidget {
  const LeakyWidget({super.key});

  @override
  State<LeakyWidget> createState() => _LeakyWidgetState();
}

class _LeakyWidgetState extends State<LeakyWidget> {
  Timer? _timer;
  int _ticks = 0;

  @override
  void initState() {
    super.initState();
    addLog('🔴 LEAKY widget — initState called');
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _ticks++;
      addLog('🔴 LEAKY tick #$_ticks  ← still running even if removed!');
      if (mounted) setState(() {});
    });
  }

  // ❌ No dispose() override.
  // _timer is never cancelled.

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bug_report, color: Colors.red, size: 16),
              const SizedBox(width: 6),
              const Text(
                'Leaky Widget',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('Ticks: $_ticks', style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 4),
          const Text(
            'No dispose() → timer never stops',
            style: TextStyle(fontSize: 11, color: Colors.red),
          ),
        ],
      ),
    );
  }
}

// FIXED Widget - Timer is cancelled in dispose().
class FixedWidget extends StatefulWidget {
  const FixedWidget({super.key});

  @override
  State<FixedWidget> createState() => _FixedWidgetState();
}

class _FixedWidgetState extends State<FixedWidget> {
  Timer? _timer;
  int _ticks = 0;

  @override
  void initState() {
    super.initState();
    addLog('🟢 FIXED widget — initState called');
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _ticks++;
      addLog('🟢 FIXED tick #$_ticks');
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // ✅ Timer stopped — no more callbacks
    addLog('🟢 FIXED widget — disposed & timer cancelled ✓');
    super.dispose(); // Always call super.dispose() last
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 16),
              const SizedBox(width: 6),
              const Text(
                'Fixed Widget',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('Ticks: $_ticks', style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 4),
          const Text(
            'dispose() cancels timer ✓',
            style: TextStyle(fontSize: 11, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
