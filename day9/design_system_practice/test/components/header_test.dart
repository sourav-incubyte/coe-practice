import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/flutter_test_patterns.dart';
import 'package:design_system_practice/components/molecules/header.dart';

void main() {
  group('Header - Golden Variants', () {
    testWidgets('Header golden variants', (tester) async {
      await goldenVariants(
        tester,
        'header',
        variants: {
          'titleOnly': () => MaterialApp(
            home: Scaffold(
              body: Header.titleOnly(title: const Text('Page Title')),
            ),
          ),
          'titleWithCTA': () => MaterialApp(
            home: Scaffold(
              body: Header.titleWithCTA(
                title: const Text('Page Title'),
                cta: const Text('Action'),
              ),
            ),
          ),
          'titleWithIcon': () => MaterialApp(
            home: Scaffold(
              body: Header.titleWithIcon(
                title: const Text('Page Title'),
                icon: const Icon(Icons.menu),
              ),
            ),
          ),
          'withSubtitle': () => MaterialApp(
            home: Scaffold(
              body: Header.titleOnly(
                title: const Text('Page Title'),
                subtitle: const Text('Page Subtitle'),
              ),
            ),
          ),
          'withActions': () => MaterialApp(
            home: Scaffold(
              body: Header.titleOnly(
                title: const Text('Page Title'),
                actions: const [Icon(Icons.search), Icon(Icons.more_vert)],
              ),
            ),
          ),
        },
      );
    });

    testWidgets('calls onActionTap when CTA is tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Header.titleWithCTA(
              title: const Text('Page Title'),
              cta: const Text('Action'),
              onActionTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Action'));
      expect(tapped, isTrue);
    });

    testWidgets('calls onIconTap when icon is tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Header.titleWithIcon(
              title: const Text('Page Title'),
              icon: const Icon(Icons.menu),
              onIconTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.menu));
      expect(tapped, isTrue);
    });

    testWidgets('has semantic label for accessibility', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Header.titleOnly(
              title: const Text('Page Title'),
              semanticLabel: 'Page Header',
            ),
          ),
        ),
      );

      final header = find.byType(Header);
      expect(header, findsOneWidget);
    });
  });
}
