import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_system_practice/design_tokens/colors.dart';

void main() {
  group('DSColors - Theme-Aware Design Tokens', () {
    testWidgets('should have primary color defined', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(DSColors.primary(context), isA<Color>());
              expect(DSColors.primary(context).value, isNotNull);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('should have secondary color defined', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(DSColors.secondary(context), isA<Color>());
              expect(DSColors.secondary(context).value, isNotNull);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    test('should have semantic colors (success, warning, error, info)', () {
      expect(DSColors.success, isA<Color>());
      expect(DSColors.warning, isA<Color>());
      expect(DSColors.error, isA<Color>());
      expect(DSColors.info, isA<Color>());
    });

    testWidgets('should have background colors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(DSColors.background(context), isA<Color>());
              expect(DSColors.backgroundSecondary(context), isA<Color>());
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('should have surface colors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(DSColors.surface(context), isA<Color>());
              expect(DSColors.surfaceVariant(context), isA<Color>());
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('should have text colors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(DSColors.textPrimary(context), isA<Color>());
              expect(DSColors.textSecondary(context), isA<Color>());
              expect(DSColors.textInverse(context), isA<Color>());
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('should have border colors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(DSColors.border(context), isA<Color>());
              expect(DSColors.borderLight(context), isA<Color>());
              expect(DSColors.borderDark(context), isA<Color>());
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });
}
