import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/flutter_test_patterns.dart';
import 'package:design_system_practice/components/atoms/ds_badge.dart';

void main() {
  group('DSBadge - Golden Variants', () {
    testWidgets('DSBadge golden variants', (tester) async {
      await goldenVariants(
        tester,
        'ds_badge',
        variants: {
          'default': () => MaterialApp(
            home: Scaffold(body: DSBadge(label: 'Badge')),
          ),
          'success': () => MaterialApp(
            home: Scaffold(body: DSBadge.success(label: 'Success')),
          ),
          'warning': () => MaterialApp(
            home: Scaffold(body: DSBadge.warning(label: 'Warning')),
          ),
          'error': () => MaterialApp(
            home: Scaffold(body: DSBadge.error(label: 'Error')),
          ),
          'info': () => MaterialApp(
            home: Scaffold(body: DSBadge.info(label: 'Info')),
          ),
          'small': () => MaterialApp(
            home: Scaffold(
              body: DSBadge(label: 'Small', size: DSBadgeSize.small),
            ),
          ),
          'medium': () => MaterialApp(
            home: Scaffold(
              body: DSBadge(label: 'Medium', size: DSBadgeSize.medium),
            ),
          ),
          'large': () => MaterialApp(
            home: Scaffold(
              body: DSBadge(label: 'Large', size: DSBadgeSize.large),
            ),
          ),
        },
      );
    });
  });

  group('DSBadge - Interaction Contracts', () {
    testWidgets('has semantic label for accessibility', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSBadge(label: 'Badge', semanticLabel: 'Status Badge'),
          ),
        ),
      );

      final badge = find.byType(DSBadge);
      expect(badge, findsOneWidget);
    });

    testWidgets('supports custom child widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSBadge(
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle),
                  SizedBox(width: 4),
                  Text('Verified'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.text('Verified'), findsOneWidget);
    });

    testWidgets('renders with icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSBadge(label: 'With Icon', icon: const Icon(Icons.star)),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });
}
