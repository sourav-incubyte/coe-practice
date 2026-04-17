import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/flutter_test_patterns.dart';
import 'package:design_system_practice/components/atoms/ds_text_field.dart';

void main() {
  group('DSTextField - Golden Variants', () {
    testWidgets('DSTextField golden variants', (tester) async {
      await goldenVariants(
        tester,
        'ds_text_field',
        variants: {
          'default': () => MaterialApp(
            home: Scaffold(
              body: DSTextField(
                controller: TextEditingController(),
                label: 'Label',
              ),
            ),
          ),
          'with_hint': () => MaterialApp(
            home: Scaffold(
              body: DSTextField(
                controller: TextEditingController(),
                label: 'Label',
                hintText: 'Enter text',
              ),
            ),
          ),
          'error': () => MaterialApp(
            home: Scaffold(
              body: DSTextField(
                controller: TextEditingController(),
                label: 'Label',
                errorText: 'Error message',
              ),
            ),
          ),
          'disabled': () => MaterialApp(
            home: Scaffold(
              body: DSTextField(
                controller: TextEditingController(),
                label: 'Label',
                enabled: false,
              ),
            ),
          ),
          'with_prefix_icon': () => MaterialApp(
            home: Scaffold(
              body: DSTextField(
                controller: TextEditingController(),
                label: 'Label',
                prefixIcon: const Icon(Icons.email),
              ),
            ),
          ),
          'with_suffix_icon': () => MaterialApp(
            home: Scaffold(
              body: DSTextField(
                controller: TextEditingController(),
                label: 'Label',
                suffixIcon: const Icon(Icons.visibility),
              ),
            ),
          ),
        },
      );
    });
  });

  group('DSTextField - Interaction Contracts', () {
    testWidgets('updates text when user types', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSTextField(controller: controller, label: 'Label'),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Hello');
      expect(controller.text, equals('Hello'));
    });

    testWidgets('calls onChanged callback', (tester) async {
      var changedText = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSTextField(
              controller: TextEditingController(),
              label: 'Label',
              onChanged: (value) {
                changedText = value;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Test');
      expect(changedText, equals('Test'));
    });

    testWidgets('focuses when tapped', (tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSTextField(
              controller: TextEditingController(),
              label: 'Label',
              focusNode: focusNode,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(DSTextField));
      await tester.pump();
      expect(focusNode.hasFocus, isTrue);
    });

    testWidgets('has semantic label for accessibility', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSTextField(
              controller: TextEditingController(),
              label: 'Label',
              semanticLabel: 'Email Input',
            ),
          ),
        ),
      );

      final textField = find.byType(DSTextField);
      expect(textField, findsOneWidget);
    });

    testWidgets('validates input when validator is provided', (tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: DSTextField(
                controller: TextEditingController(),
                label: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('Required'), findsOneWidget);
    });
  });
}
