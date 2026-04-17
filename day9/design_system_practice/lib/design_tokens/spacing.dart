/// Immutable spacing tokens for the design system
/// Principle #6: Foundation Tokens Are Immutable
class DSSpacing {
  DSSpacing._();

  // Base spacing unit (4px scale)
  static const double base = 4.0;

  // Scale-based spacing values
  static const double xxs = base * 0.5; // 2px
  static const double xs = base; // 4px
  static const double sm = base * 1.5; // 6px
  static const double md = base * 2; // 8px
  static const double lg = base * 3; // 12px
  static const double xl = base * 4; // 16px
  static const double xxl = base * 6; // 24px

  // Component-specific spacing
  static const double paddingSmall = xs; // 4px
  static const double paddingMedium = md; // 8px
  static const double paddingLarge = xl; // 16px

  static const double gapSmall = xs; // 4px
  static const double gapMedium = md; // 8px
  static const double gapLarge = xl; // 16px
}
