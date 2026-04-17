/// Immutable radius tokens for the design system
/// Principle #6: Foundation Tokens Are Immutable
class DSRadius {
  DSRadius._();

  // Base radius unit (4px scale)
  static const double base = 4.0;

  // Scale-based radius values
  static const double xxs = base * 0.5; // 2px
  static const double xs = base; // 4px
  static const double sm = base * 1.5; // 6px
  static const double md = base * 2; // 8px
  static const double lg = base * 3; // 12px
  static const double xl = base * 4; // 16px
  static const double xxl = base * 6; // 24px

  // Component-specific radius values
  static const double buttonSmall = xs; // 4px
  static const double buttonMedium = sm; // 6px
  static const double buttonLarge = md; // 8px

  static const double card = md; // 8px
  static const double input = sm; // 6px
  static const double chip = xl; // 16px

  // Special radius values
  static const double circle = 9999.0; // Full circle
  static const double pill = 9999.0; // Full pill
}
