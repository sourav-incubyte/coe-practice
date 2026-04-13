import 'dart:async';
import 'package:flutter/material.dart';

// EXERCISE 4: Async Error Handling and Streams
// PROBLEM: Errors in async code and streams can be hard to handle
// TASK: Learn proper error handling for async operations and streams

// ===== ASYNC ERROR HANDLING WITH AWAIT =====

// GOOD: Using try-catch with async/await
class AsyncServiceGood {
  Future<String> fetchData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (DateTime.now().second % 2 == 0) {
        throw Exception('Random error occurred');
      }
      return 'Data fetched successfully';
    } catch (e) {
      return 'Error: $e';
    }
  }
}

// GOOD: Using catchError
class AsyncServiceCatchError {
  Future<String> fetchData() {
    return Future.delayed(const Duration(seconds: 1))
        .then((_) => 'Data fetched successfully')
        .catchError((error) => 'Error: $error');
  }
}

// ===== STREAM ERROR HANDLING =====

// GOOD: Using error handler in listen
class StreamServiceGood {
  Stream<int> getDataStream() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (i == 5) {
        throw Exception('Error at index $i');
      }
      yield i;
    }
  }

  void listenToStream() {
    getDataStream().listen(
      (data) => print('Data: $data'),
      onError: (error) => print('Stream error: $error'),
      onDone: () => print('Stream completed'),
    );
  }
}

// GOOD: Using try-catch with await for
class StreamServiceAwaitFor {
  Future<void> processStream() async {
    try {
      await for (final data in getDataStream()) {
        print('Data: $data');
      }
    } catch (e) {
      print('Stream error: $e');
    }
  }

  Stream<int> getDataStream() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (i == 5) {
        throw Exception('Error at index $i');
      }
      yield i;
    }
  }
}

// GOOD: Using handleError in Stream
class StreamServiceHandleError {
  Stream<int> getDataStream() {
    return Stream.periodic(const Duration(milliseconds: 500), (i) => i)
        .take(10)
        .map((i) {
          if (i == 5) throw Exception('Error at index $i');
          return i;
        })
        .handleError((error) {
          print('Handled stream error: $error');
          return -1; // Provide fallback value
        });
  }
}

// ===== COMPLETER ERROR HANDLING =====

// GOOD: Using Completer for manual async operations
class CompleterService {
  Future<String> performAsyncOperation() {
    final completer = Completer<String>();

    // Simulate async operation
    Future.delayed(const Duration(seconds: 1)).then((_) {
      if (DateTime.now().second % 2 == 0) {
        completer.completeError(Exception('Operation failed'));
      } else {
        completer.complete('Operation succeeded');
      }
    });

    return completer.future;
  }
}

// ===== DEMO APP =====
class AsyncErrorHandlingExerciseApp extends StatelessWidget {
  const AsyncErrorHandlingExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Async Error Handling Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const AsyncErrorHandlingScreen(),
    );
  }
}

class AsyncErrorHandlingScreen extends StatefulWidget {
  const AsyncErrorHandlingScreen({super.key});

  @override
  State<AsyncErrorHandlingScreen> createState() =>
      _AsyncErrorHandlingScreenState();
}

class _AsyncErrorHandlingScreenState extends State<AsyncErrorHandlingScreen> {
  final _asyncServiceGood = AsyncServiceGood();
  final _streamServiceGood = StreamServiceGood();
  final _completerService = CompleterService();

  final List<String> _logs = [];
  StreamSubscription<int>? _streamSubscription;
  bool _isStreamActive = false;

  void _addLog(String message) {
    setState(() {
      _logs.add('${DateTime.now().toString().substring(11, 19)}: $message');
    });
  }

  Future<void> _testAsyncAwait() async {
    _addLog('Testing async/await error handling...');
    final result = await _asyncServiceGood.fetchData();
    _addLog('Result: $result');
  }

  void _testStreamListen() {
    if (_isStreamActive) {
      _streamSubscription?.cancel();
      setState(() => _isStreamActive = false);
      _addLog('Stream cancelled');
      return;
    }

    _addLog('Starting stream with listen()...');
    setState(() => _isStreamActive = true);

    _streamSubscription = _streamServiceGood.getDataStream().listen(
      (data) => _addLog('Stream data: $data'),
      onError: (error) => _addLog('Stream error: $error'),
      onDone: () {
        _addLog('Stream completed');
        setState(() => _isStreamActive = false);
      },
    );
  }

  Future<void> _testStreamAwaitFor() async {
    _addLog('Testing stream with await for...');
    try {
      await for (final data in StreamServiceAwaitFor().getDataStream()) {
        _addLog('Stream data: $data');
      }
      _addLog('Stream completed');
    } catch (e) {
      _addLog('Stream error: $e');
    }
  }

  Future<void> _testCompleter() async {
    _addLog('Testing Completer error handling...');
    try {
      final result = await _completerService.performAsyncOperation();
      _addLog('Result: $result');
    } catch (e) {
      _addLog('Error: $e');
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4: Async Error Handling'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Async Error Handling & Streams',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 10,
                      children: [
                        ElevatedButton(
                          onPressed: _testAsyncAwait,
                          child: const Text('Test async/await'),
                        ),
                        ElevatedButton(
                          onPressed: _testStreamListen,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isStreamActive
                                ? Colors.red
                                : null,
                          ),
                          child: Text(
                            _isStreamActive ? 'Stop Stream' : 'Start Stream',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _testStreamAwaitFor,
                          child: const Text('Test await for'),
                        ),
                        ElevatedButton(
                          onPressed: _testCompleter,
                          child: const Text('Test Completer'),
                        ),
                        ElevatedButton(
                          onPressed: () => setState(() => _logs.clear()),
                          child: const Text('Clear Logs'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),
                    const Text(
                      'Error Handling Patterns:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildPatternCard(
                      'async/await with try-catch',
                      '```dart\ntry {\n  await riskyOperation();\n} catch (e) {\n  handleError(e);\n}\n```',
                      Colors.blue,
                    ),
                    const SizedBox(height: 10),
                    _buildPatternCard(
                      'Future.catchError()',
                      '```dart\nfuture.catchError((error) {\n  return handleError(error);\n});\n```',
                      Colors.green,
                    ),
                    const SizedBox(height: 10),
                    _buildPatternCard(
                      'Stream.listen(onError)',
                      '```dart\nstream.listen(\n  (data) => handleData(data),\n  onError: (error) => handleError(error),\n);\n```',
                      Colors.orange,
                    ),
                    const SizedBox(height: 10),
                    _buildPatternCard(
                      'await for with try-catch',
                      '```dart\ntry {\n  await for (final data in stream) {\n    handleData(data);\n  }\n} catch (e) {\n  handleError(e);\n}\n```',
                      Colors.purple,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: Container(
              color: Colors.grey[900],
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  final log = _logs[index];
                  final isError =
                      log.contains('Error') || log.contains('error');
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      log,
                      style: TextStyle(
                        color: isError ? Colors.red : Colors.green,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatternCard(String title, String code, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                code,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
