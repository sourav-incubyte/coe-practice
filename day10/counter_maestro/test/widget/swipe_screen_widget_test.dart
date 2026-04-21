import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_maestro/screens/swipe_screen.dart';

void main() {
  group('SwipeScreen Widget Tests', () {
    testWidgets('SwipeScreen renders correctly with initial state', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SwipeScreen(),
        ),
      );

      expect(find.text('Swipe to navigate items'), findsOneWidget);
      expect(find.byKey(const Key('swipe_container')), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.byKey(const Key('prev_button')), findsOneWidget);
      expect(find.byKey(const Key('next_button')), findsOneWidget);
    });

    testWidgets('Initial item is Item 1', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SwipeScreen(),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('Next button navigates to next item', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SwipeScreen(),
        ),
      );

      await tester.tap(find.byKey(const Key('next_button')));
      await tester.pump();

      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 1'), findsNothing);
    });

    testWidgets('Previous button is disabled on first item', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SwipeScreen(),
        ),
      );

      final prevButton = tester.widget<ElevatedButton>(
        find.byKey(const Key('prev_button')),
      );

      expect(prevButton.onPressed, isNull);
    });

    testWidgets('Previous button navigates to previous item', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SwipeScreen(),
        ),
      );

      // Navigate to item 3
      await tester.tap(find.byKey(const Key('next_button')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('next_button')));
      await tester.pump();

      expect(find.text('Item 3'), findsOneWidget);

      // Navigate back to item 2
      await tester.tap(find.byKey(const Key('prev_button')));
      await tester.pump();

      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsNothing);
    });

    testWidgets('Next button is disabled on last item', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SwipeScreen(),
        ),
      );

      // Navigate to the last item (Item 5)
      for (int i = 0; i < 4; i++) {
        await tester.tap(find.byKey(const Key('next_button')));
        await tester.pump();
      }

      expect(find.text('Item 5'), findsOneWidget);

      final nextButton = tester.widget<ElevatedButton>(
        find.byKey(const Key('next_button')),
      );

      expect(nextButton.onPressed, isNull);
    });

    testWidgets('Multiple next button navigations work correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SwipeScreen(),
        ),
      );

      await tester.tap(find.byKey(const Key('next_button')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('next_button')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('next_button')));
      await tester.pump();

      expect(find.text('Item 4'), findsOneWidget);
    });

    testWidgets('Navigation through all items works correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SwipeScreen(),
        ),
      );

      // Navigate forward through all items
      for (int i = 1; i <= 5; i++) {
        expect(find.text('Item $i'), findsOneWidget);
        if (i < 5) {
          await tester.tap(find.byKey(const Key('next_button')));
          await tester.pump();
        }
      }

      // Navigate backward through all items
      for (int i = 5; i >= 1; i--) {
        expect(find.text('Item $i'), findsOneWidget);
        if (i > 1) {
          await tester.tap(find.byKey(const Key('prev_button')));
          await tester.pump();
        }
      }
    });
  });
}
