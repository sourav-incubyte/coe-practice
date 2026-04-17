import 'package:flutter_test/flutter_test.dart';
import 'package:design_system_practice/design_tokens/spacing.dart';

void main() {
  group('DSSpacing - Immutable Design Tokens', () {
    test('should have base spacing unit defined', () {
      expect(DSSpacing.base, greaterThan(0));
      expect(DSSpacing.base, isA<double>());
    });

    test('should have scale-based spacing values', () {
      expect(DSSpacing.xxs, greaterThan(0));
      expect(DSSpacing.xs, greaterThan(0));
      expect(DSSpacing.sm, greaterThan(0));
      expect(DSSpacing.md, greaterThan(0));
      expect(DSSpacing.lg, greaterThan(0));
      expect(DSSpacing.xl, greaterThan(0));
      expect(DSSpacing.xxl, greaterThan(0));
    });

    test('should have consistent spacing scale (multiples of base)', () {
      final base = DSSpacing.base;
      expect(DSSpacing.xxs, equals(base * 0.5));
      expect(DSSpacing.xs, equals(base));
      expect(DSSpacing.sm, equals(base * 1.5));
      expect(DSSpacing.md, equals(base * 2));
      expect(DSSpacing.lg, equals(base * 3));
      expect(DSSpacing.xl, equals(base * 4));
      expect(DSSpacing.xxl, equals(base * 6));
    });

    test('should have component-specific spacing', () {
      expect(DSSpacing.paddingSmall, greaterThan(0));
      expect(DSSpacing.paddingMedium, greaterThan(0));
      expect(DSSpacing.paddingLarge, greaterThan(0));
      expect(DSSpacing.gapSmall, greaterThan(0));
      expect(DSSpacing.gapMedium, greaterThan(0));
      expect(DSSpacing.gapLarge, greaterThan(0));
    });
  });
}
