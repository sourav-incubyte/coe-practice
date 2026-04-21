import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_maestro/screens/counter_screen.dart';

void main() {
  group('CounterScreen Widget Tests', () {
    testWidgets('CounterScreen renders correctly with initial state', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: CounterScreen()));

      expect(
        find.text('You have pushed the button this many times:'),
        findsOneWidget,
      );
      expect(find.text('0'), findsOneWidget);
      expect(find.byKey(const Key('Increment')), findsOneWidget);
      expect(find.byKey(const Key('Decrement')), findsOneWidget);
    });

    testWidgets('Increment button is tappable and updates counter', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: CounterScreen()));

      await tester.tap(find.byKey(const Key('Increment')));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('Decrement button is tappable and updates counter', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: CounterScreen()));

      await tester.tap(find.byKey(const Key('Decrement')));
      await tester.pump();

      expect(find.text('-1'), findsOneWidget);
    });

    testWidgets('Multiple increment operations', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CounterScreen()));

      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byKey(const Key('Increment')));
        await tester.pump();
      }

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('Multiple decrement operations', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CounterScreen()));

      for (int i = 0; i < 3; i++) {
        await tester.tap(find.byKey(const Key('Decrement')));
        await tester.pump();
      }

      expect(find.text('-3'), findsOneWidget);
    });

    testWidgets('Combined increment and decrement operations', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CounterScreen()));

      await tester.tap(find.byKey(const Key('Increment')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('Increment')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('Decrement')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('Increment')));
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
    });
  });
}
