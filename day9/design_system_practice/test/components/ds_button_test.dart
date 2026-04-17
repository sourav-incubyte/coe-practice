import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/flutter_test_patterns.dart';
import 'package:design_system_practice/components/atoms/ds_button.dart';

void main() {
  group('DSButton - Golden Variants', () {
    testWidgets('DSButton golden variants', (tester) async {
      await goldenVariants(
        tester,
        'ds_button',
        variants: {
          'primary': () => MaterialApp(
            home: Scaffold(
              body: DSButton.primary(
                onPressed: () {},
                child: const Text('Primary'),
              ),
            ),
          ),
          'secondary': () => MaterialApp(
            home: Scaffold(
              body: DSButton.secondary(
                onPressed: () {},
                child: const Text('Secondary'),
              ),
            ),
          ),
          'ghost': () => MaterialApp(
            home: Scaffold(
              body: DSButton.ghost(
                onPressed: () {},
                child: const Text('Ghost'),
              ),
            ),
          ),
          'disabled': () => MaterialApp(
            home: Scaffold(
              body: DSButton.primary(
                onPressed: null,
                child: const Text('Disabled'),
              ),
            ),
          ),
          'small': () => MaterialApp(
            home: Scaffold(
              body: DSButton.primary(
                onPressed: () {},
                size: DSButtonSize.small,
                child: const Text('Small'),
              ),
            ),
          ),
          'medium': () => MaterialApp(
            home: Scaffold(
              body: DSButton.primary(
                onPressed: () {},
                size: DSButtonSize.medium,
                child: const Text('Medium'),
              ),
            ),
          ),
          'large': () => MaterialApp(
            home: Scaffold(
              body: DSButton.primary(
                onPressed: () {},
                size: DSButtonSize.large,
                child: const Text('Large'),
              ),
            ),
          ),
          'full_width': () => MaterialApp(
            home: Scaffold(
              body: DSButton.primary(
                onPressed: () {},
                fullWidth: true,
                child: const Text('Full Width'),
              ),
            ),
          ),
        },
      );
    });
  });

  group('DSButton - Interaction Contracts', () {
    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSButton.primary(
              onPressed: () {
                tapped = true;
              },
              child: const Text('Tap Me'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      expect(tapped, isTrue);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSButton.primary(
              onPressed: () {
                tapped = true;
              },
              enabled: false,
              child: const Text('Disabled'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Disabled'));
      expect(tapped, isFalse);
    });

    testWidgets('has semantic label for accessibility', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSButton.primary(
              onPressed: () {},
              semanticLabel: 'Submit Button',
              child: const Text('Submit'),
            ),
          ),
        ),
      );

      final button = find.byType(DSButton);
      expect(button, findsOneWidget);
    });

    testWidgets('supports custom child widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSButton.primary(
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star),
                  SizedBox(width: 8),
                  Text('Custom'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Custom'), findsOneWidget);
    });
  });
}
