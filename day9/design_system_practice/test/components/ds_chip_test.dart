import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/flutter_test_patterns.dart';
import 'package:design_system_practice/components/atoms/ds_chip.dart';

void main() {
  group('DSChip - Golden Variants', () {
    testWidgets('DSChip golden variants', (tester) async {
      await goldenVariants(
        tester,
        'ds_chip',
        variants: {
          'default': () => MaterialApp(
            home: Scaffold(body: DSChip(label: 'Chip')),
          ),
          'selected': () => MaterialApp(
            home: Scaffold(body: DSChip(label: 'Selected', selected: true)),
          ),
          'unselected': () => MaterialApp(
            home: Scaffold(body: DSChip(label: 'Unselected', selected: false)),
          ),
          'small': () => MaterialApp(
            home: Scaffold(
              body: DSChip(label: 'Small', size: DSChipSize.small),
            ),
          ),
          'medium': () => MaterialApp(
            home: Scaffold(
              body: DSChip(label: 'Medium', size: DSChipSize.medium),
            ),
          ),
          'large': () => MaterialApp(
            home: Scaffold(
              body: DSChip(label: 'Large', size: DSChipSize.large),
            ),
          ),
          'with_icon': () => MaterialApp(
            home: Scaffold(
              body: DSChip(label: 'With Icon', icon: const Icon(Icons.star)),
            ),
          ),
        },
      );
    });
  });

  group('DSChip - Interaction Contracts', () {
    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSChip(
              label: 'Tap Me',
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      expect(tapped, isTrue);
    });

    testWidgets('does not call onTap when disabled', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSChip(
              label: 'Disabled',
              onTap: () {
                tapped = true;
              },
              enabled: false,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Disabled'));
      expect(tapped, isFalse);
    });

    testWidgets('toggles selected state when tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSChip(
              label: 'Toggle',
              selected: false,
              onSelected: (selected) {},
            ),
          ),
        ),
      );

      await tester.tap(find.text('Toggle'));
      await tester.pump();
    });

    testWidgets('has semantic label for accessibility', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSChip(label: 'Chip', semanticLabel: 'Filter Chip'),
          ),
        ),
      );

      final chip = find.byType(DSChip);
      expect(chip, findsOneWidget);
    });

    testWidgets('supports custom child widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSChip(
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check),
                  SizedBox(width: 4),
                  Text('Custom'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.text('Custom'), findsOneWidget);
    });
  });
}
