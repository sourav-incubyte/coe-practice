import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_system_practice/design_tokens/typography.dart';

void main() {
  group('DSTypography - Immutable Design Tokens', () {
    test('should have heading styles defined', () {
      expect(DSTypography.h1, isA<TextStyle>());
      expect(DSTypography.h2, isA<TextStyle>());
      expect(DSTypography.h3, isA<TextStyle>());
      expect(DSTypography.h4, isA<TextStyle>());
      expect(DSTypography.h5, isA<TextStyle>());
      expect(DSTypography.h6, isA<TextStyle>());
    });

    test('should have body text styles defined', () {
      expect(DSTypography.bodyLarge, isA<TextStyle>());
      expect(DSTypography.bodyMedium, isA<TextStyle>());
      expect(DSTypography.bodySmall, isA<TextStyle>());
    });

    test('should have label styles defined', () {
      expect(DSTypography.labelLarge, isA<TextStyle>());
      expect(DSTypography.labelMedium, isA<TextStyle>());
      expect(DSTypography.labelSmall, isA<TextStyle>());
    });

    test('should have consistent font family', () {
      final fontFamily = DSTypography.h1.fontFamily;
      expect(fontFamily, isNotNull);
      expect(DSTypography.bodyLarge.fontFamily, equals(fontFamily));
    });

    test('should have decreasing font sizes for headings', () {
      expect(DSTypography.h1.fontSize!, greaterThan(DSTypography.h2.fontSize!));
      expect(DSTypography.h2.fontSize!, greaterThan(DSTypography.h3.fontSize!));
      expect(DSTypography.h3.fontSize!, greaterThan(DSTypography.h4.fontSize!));
      expect(DSTypography.h4.fontSize!, greaterThan(DSTypography.h5.fontSize!));
      expect(DSTypography.h5.fontSize!, greaterThan(DSTypography.h6.fontSize!));
    });

    test('should have decreasing font sizes for body text', () {
      expect(
        DSTypography.bodyLarge.fontSize!,
        greaterThan(DSTypography.bodyMedium.fontSize!),
      );
      expect(
        DSTypography.bodyMedium.fontSize!,
        greaterThan(DSTypography.bodySmall.fontSize!),
      );
    });

    test('should have decreasing font sizes for labels', () {
      expect(
        DSTypography.labelLarge.fontSize!,
        greaterThan(DSTypography.labelMedium.fontSize!),
      );
      expect(
        DSTypography.labelMedium.fontSize!,
        greaterThan(DSTypography.labelSmall.fontSize!),
      );
    });

    test('should have font weights defined', () {
      expect(DSTypography.h1.fontWeight, isNotNull);
      expect(DSTypography.bodyLarge.fontWeight, isNotNull);
      expect(DSTypography.labelLarge.fontWeight, isNotNull);
    });
  });
}
