import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Counter Logic Unit Tests', () {
    test('counter starts at 0', () {
      const initialCounter = 0;
      expect(initialCounter, equals(0));
    });

    test('increment operation increases counter by 1', () {
      var counter = 0;
      counter++;
      expect(counter, equals(1));
    });

    test('increment operation multiple times', () {
      var counter = 0;
      for (int i = 0; i < 5; i++) {
        counter++;
      }
      expect(counter, equals(5));
    });

    test('decrement operation decreases counter by 1', () {
      var counter = 5;
      counter--;
      expect(counter, equals(4));
    });

    test('decrement operation multiple times', () {
      var counter = 10;
      for (int i = 0; i < 3; i++) {
        counter--;
      }
      expect(counter, equals(7));
    });

    test('increment and decrement operations combined', () {
      var counter = 0;
      counter++;
      counter++;
      counter--;
      counter++;
      expect(counter, equals(2));
    });

    test('counter can go negative', () {
      var counter = 0;
      counter--;
      expect(counter, equals(-1));
    });

    test('counter can be large positive number', () {
      var counter = 0;
      for (int i = 0; i < 100; i++) {
        counter++;
      }
      expect(counter, equals(100));
    });
  });
}
