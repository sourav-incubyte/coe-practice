import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_maestro/main.dart';

void main() {
  group('MainScreen Widget Tests', () {
    testWidgets('MainScreen renders correctly with initial state', (tester) async {
      await tester.pumpWidget(
        const MyApp(),
      );

      expect(find.text('Maestro Test Demo'), findsOneWidget);
      expect(find.byKey(const Key('Counter')), findsOneWidget);
      expect(find.byKey(const Key('Input')), findsOneWidget);
      expect(find.byKey(const Key('Scroll')), findsOneWidget);
      expect(find.byKey(const Key('Swipe')), findsOneWidget);
    });

    testWidgets('Counter button navigates to CounterScreen', (tester) async {
      await tester.pumpWidget(
        const MyApp(),
      );

      await tester.tap(find.byKey(const Key('Counter')));
      await tester.pump();

      expect(find.text('You have pushed the button this many times:'), findsOneWidget);
      expect(find.byKey(const Key('Increment')), findsOneWidget);
      expect(find.byKey(const Key('Decrement')), findsOneWidget);
    });

    testWidgets('Input button navigates to InputScreen', (tester) async {
      await tester.pumpWidget(
        const MyApp(),
      );

      await tester.tap(find.byKey(const Key('Input')));
      await tester.pump();

      expect(find.text('Input Form Test'), findsOneWidget);
      expect(find.byKey(const Key('name_field')), findsOneWidget);
      expect(find.byKey(const Key('email_field')), findsOneWidget);
    });

    testWidgets('Scroll button navigates to ScrollScreen', (tester) async {
      await tester.pumpWidget(
        const MyApp(),
      );

      await tester.tap(find.byKey(const Key('Scroll')));
      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('Swipe button navigates to SwipeScreen', (tester) async {
      await tester.pumpWidget(
        const MyApp(),
      );

      await tester.tap(find.byKey(const Key('Swipe')));
      await tester.pump();

      expect(find.text('Swipe to navigate items'), findsOneWidget);
      expect(find.byKey(const Key('swipe_container')), findsOneWidget);
      expect(find.byKey(const Key('prev_button')), findsOneWidget);
      expect(find.byKey(const Key('next_button')), findsOneWidget);
    });

    testWidgets('Navigation between screens works correctly', (tester) async {
      await tester.pumpWidget(
        const MyApp(),
      );

      // Start on Counter screen (default)
      expect(find.text('You have pushed the button this many times:'), findsOneWidget);

      // Navigate to Input
      await tester.tap(find.byKey(const Key('Input')));
      await tester.pump();
      expect(find.text('Input Form Test'), findsOneWidget);

      // Navigate to Scroll
      await tester.tap(find.byKey(const Key('Scroll')));
      await tester.pump();
      expect(find.byType(ListView), findsOneWidget);

      // Navigate to Swipe
      await tester.tap(find.byKey(const Key('Swipe')));
      await tester.pump();
      expect(find.text('Swipe to navigate items'), findsOneWidget);

      // Navigate back to Counter
      await tester.tap(find.byKey(const Key('Counter')));
      await tester.pump();
      expect(find.text('You have pushed the button this many times:'), findsOneWidget);
    });

    testWidgets('App bar title is correct', (tester) async {
      await tester.pumpWidget(
        const MyApp(),
      );

      expect(find.text('Maestro Test Demo'), findsOneWidget);
    });

    testWidgets('IndexedStack maintains state when switching screens', (tester) async {
      await tester.pumpWidget(
        const MyApp(),
      );

      // Increment counter
      await tester.tap(find.byKey(const Key('Increment')));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);

      // Switch to Input screen
      await tester.tap(find.byKey(const Key('Input')));
      await tester.pump();

      // Switch back to Counter screen
      await tester.tap(find.byKey(const Key('Counter')));
      await tester.pump();

      // Counter should still be 1 (state preserved)
      expect(find.text('1'), findsOneWidget);
    });
  });
}
