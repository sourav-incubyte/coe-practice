import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_system_practice/components/molecules/card.dart';
import 'package:design_system_practice/design_tokens/colors.dart';

void main() {
  group('DSCard - State Matrix', () {
    testWidgets('renders default card correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: DSCard(child: const Text('Card Content'))),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('renders with title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSCard(
              title: const Text('Card Title'),
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Title'), findsOneWidget);
      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('renders with elevation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSCard(elevation: 4, child: const Text('Card Content')),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('renders with onTap', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSCard(
              onTap: () {
                tapped = true;
              },
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Card Content'));
      expect(tapped, isTrue);
    });

    testWidgets('renders with disabled state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSCard(enabled: false, child: const Text('Card Content')),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('does not call onTap when disabled', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSCard(
              onTap: () {
                tapped = true;
              },
              enabled: false,
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Card Content'));
      expect(tapped, isFalse);
    });

    testWidgets('renders with custom padding', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSCard(
              padding: const EdgeInsets.all(24),
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('has semantic label for accessibility', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSCard(
              semanticLabel: 'Info Card',
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      final card = find.byType(DSCard);
      expect(card, findsOneWidget);
    });

    testWidgets('renders with custom background color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSCard(
              backgroundColor: DSColors.success,
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
    });
  });
}
