import 'package:flutter_test/flutter_test.dart';
import 'package:design_system_practice/design_tokens/radius.dart';

void main() {
  group('DSRadius - Immutable Design Tokens', () {
    test('should have base radius unit defined', () {
      expect(DSRadius.base, greaterThan(0));
      expect(DSRadius.base, isA<double>());
    });

    test('should have scale-based radius values', () {
      expect(DSRadius.xxs, greaterThan(0));
      expect(DSRadius.xs, greaterThan(0));
      expect(DSRadius.sm, greaterThan(0));
      expect(DSRadius.md, greaterThan(0));
      expect(DSRadius.lg, greaterThan(0));
      expect(DSRadius.xl, greaterThan(0));
      expect(DSRadius.xxl, greaterThan(0));
    });

    test('should have consistent radius scale (multiples of base)', () {
      final base = DSRadius.base;
      expect(DSRadius.xxs, equals(base * 0.5));
      expect(DSRadius.xs, equals(base));
      expect(DSRadius.sm, equals(base * 1.5));
      expect(DSRadius.md, equals(base * 2));
      expect(DSRadius.lg, equals(base * 3));
      expect(DSRadius.xl, equals(base * 4));
      expect(DSRadius.xxl, equals(base * 6));
    });

    test('should have component-specific radius values', () {
      expect(DSRadius.buttonSmall, greaterThan(0));
      expect(DSRadius.buttonMedium, greaterThan(0));
      expect(DSRadius.buttonLarge, greaterThan(0));
      expect(DSRadius.card, greaterThan(0));
      expect(DSRadius.input, greaterThan(0));
      expect(DSRadius.chip, greaterThan(0));
    });

    test('should have circle radius', () {
      expect(DSRadius.circle, greaterThan(0));
    });

    test('should have pill radius', () {
      expect(DSRadius.pill, greaterThan(0));
    });
  });
}
