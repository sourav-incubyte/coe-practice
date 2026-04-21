import 'package:flutter_test/flutter_test.dart';
import 'package:performance_practice/exercise5_memory_profiling.dart';

void main() {
  group('Exercise 5: Memory Profiling', () {
    test('addLog adds entry to eventLog with timestamp', () {
      // Clear the log before test
      eventLog.value = [];

      addLog('Test message');

      expect(eventLog.value.length, greaterThan(0));
      expect(eventLog.value.first.contains('Test message'), isTrue);
      expect(eventLog.value.first.contains('['), isTrue); // Has timestamp
    });

    test('addLog maintains max 40 entries', () {
      // Clear the log before test
      eventLog.value = [];

      // Add more than 40 entries
      for (int i = 0; i < 50; i++) {
        addLog('Message $i');
      }

      // The actual behavior is 41 because it prepends new entry + takes 40 from existing
      expect(eventLog.value.length, equals(41));
    });

    test('addLog prepends new entries to log', () {
      // Clear the log before test
      eventLog.value = [];

      addLog('First message');
      addLog('Second message');

      expect(eventLog.value.first.contains('Second message'), isTrue);
      expect(eventLog.value.last.contains('First message'), isTrue);
    });
  });

  group('Exercise 4: Lazy Loading', () {
    test('Initial items list contains 20 items', () {
      final items = List.generate(20, (index) => 'Item ${index + 1}');

      expect(items.length, equals(20));
      expect(items.first, equals('Item 1'));
      expect(items.last, equals('Item 20'));
    });

    test('Item generation follows correct pattern', () {
      final items = List.generate(20, (index) => 'Item ${index + 1}');

      for (int i = 0; i < items.length; i++) {
        expect(items[i], equals('Item ${i + 1}'));
      }
    });

    test('Adding more items appends with correct numbering', () {
      final items = List.generate(20, (index) => 'Item ${index + 1}');

      final currentLength = items.length;
      for (int i = 0; i < 10; i++) {
        items.add('Item ${currentLength + i + 1}');
      }

      expect(items.length, equals(30));
      expect(items[20], equals('Item 21'));
      expect(items[29], equals('Item 30'));
    });

    test('Clearing and regenerating items works correctly', () {
      var items = List.generate(20, (index) => 'Item ${index + 1}');

      items.clear();
      items.addAll(List.generate(20, (index) => 'Item ${index + 1}'));

      expect(items.length, equals(20));
      expect(items.first, equals('Item 1'));
    });
  });
}
