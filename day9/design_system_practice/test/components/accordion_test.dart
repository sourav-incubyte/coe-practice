import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_system_practice/components/molecules/accordion.dart';

void main() {
  group('Accordion - State Matrix', () {
    testWidgets('renders collapsed state correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Accordion(
              title: const Text('Accordion Title'),
              content: const Text('Accordion Content'),
              expanded: false,
              onExpandedChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Accordion Title'), findsOneWidget);
      expect(find.text('Accordion Content'), findsNothing);
    });

    testWidgets('renders expanded state correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Accordion(
              title: const Text('Accordion Title'),
              content: const Text('Accordion Content'),
              expanded: true,
              onExpandedChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Accordion Title'), findsOneWidget);
      expect(find.text('Accordion Content'), findsOneWidget);
    });

    testWidgets('renders disabled state correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Accordion(
              title: const Text('Accordion Title'),
              content: const Text('Accordion Content'),
              expanded: false,
              onExpandedChanged: (_) {},
              enabled: false,
            ),
          ),
        ),
      );

      expect(find.text('Accordion Title'), findsOneWidget);
      expect(find.text('Accordion Content'), findsNothing);
    });

    testWidgets('toggles expansion when tapped', (tester) async {
      var expanded = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Accordion(
              title: const Text('Accordion Title'),
              content: const Text('Accordion Content'),
              expanded: expanded,
              onExpandedChanged: (isExpanded) {
                expanded = isExpanded;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Accordion Title'));
      await tester.pump();
      expect(expanded, isTrue);
    });

    testWidgets('collapses when tapped while expanded', (tester) async {
      var expanded = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Accordion(
              title: const Text('Accordion Title'),
              content: const Text('Accordion Content'),
              expanded: expanded,
              onExpandedChanged: (isExpanded) {
                expanded = isExpanded;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Accordion Title'));
      await tester.pump();
      expect(expanded, isFalse);
    });

    testWidgets('does not toggle when disabled', (tester) async {
      var expanded = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Accordion(
              title: const Text('Accordion Title'),
              content: const Text('Accordion Content'),
              expanded: expanded,
              onExpandedChanged: (isExpanded) {
                expanded = isExpanded;
              },
              enabled: false,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Accordion Title'));
      await tester.pump();
      expect(expanded, isFalse);
    });

    testWidgets('renders with custom icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Accordion(
              title: const Text('Accordion Title'),
              content: const Text('Accordion Content'),
              expanded: false,
              onExpandedChanged: (_) {},
              icon: const Icon(Icons.star),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('has semantic label for accessibility', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Accordion(
              title: const Text('Accordion Title'),
              content: const Text('Accordion Content'),
              expanded: false,
              onExpandedChanged: (_) {},
              semanticLabel: 'Details Accordion',
            ),
          ),
        ),
      );

      final accordion = find.byType(Accordion);
      expect(accordion, findsOneWidget);
    });

    testWidgets('supports custom title widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Accordion(
              title: const Row(
                children: [
                  Icon(Icons.info),
                  SizedBox(width: 8),
                  Text('Custom Title'),
                ],
              ),
              content: const Text('Accordion Content'),
              expanded: false,
              onExpandedChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.info), findsOneWidget);
      expect(find.text('Custom Title'), findsOneWidget);
    });
  });
}
