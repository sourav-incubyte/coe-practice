import 'package:flutter/material.dart';

/// Theme-aware color tokens for the design system
/// Colors adapt based on the current theme (Light/Dark)
class DSColors {
  DSColors._();

  /// Get primary color from theme
  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  /// Get primary color with fixed fallback for light theme
  static Color primaryLight(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? const Color(0xFF3388DD)
      : Theme.of(context).colorScheme.primary;

  /// Get primary color with fixed fallback for dark theme
  static Color primaryDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF004C99)
      : Theme.of(context).colorScheme.primary;

  /// Get secondary color from theme
  static Color secondary(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  /// Get secondary color with fixed fallback for light theme
  static Color secondaryLight(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? const Color(0xFF8B4DB8)
      : Theme.of(context).colorScheme.secondary;

  /// Get secondary color with fixed fallback for dark theme
  static Color secondaryDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF4C1D75)
      : Theme.of(context).colorScheme.secondary;

  // Semantic colors - these remain fixed as they are semantic
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  /// Get background color from theme
  static Color background(BuildContext context) =>
      Theme.of(context).colorScheme.background;

  /// Get secondary background color
  static Color backgroundSecondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFF9FAFB)
      : const Color(0xFF1F2937);

  /// Get tertiary background color
  static Color backgroundTertiary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFF3F4F6)
      : const Color(0xFF374151);

  /// Get surface color from theme
  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  /// Get surface variant color
  static Color surfaceVariant(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFF8FAFC)
      : const Color(0xFF1E293B);

  /// Get primary text color from theme
  static Color textPrimary(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  /// Get secondary text color
  static Color textSecondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? const Color(0xFF6B7280)
      : const Color(0xFF9CA3AF);

  /// Get tertiary text color
  static Color textTertiary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? const Color(0xFF9CA3AF)
      : const Color(0xFF6B7280);

  /// Get inverse text color
  static Color textInverse(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimary;

  /// Get border color
  static Color border(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFE5E7EB)
      : const Color(0xFF374151);

  /// Get light border color
  static Color borderLight(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFF3F4F6)
      : const Color(0xFF4B5563);

  /// Get dark border color
  static Color borderDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFD1D5DB)
      : const Color(0xFF1F2937);

  /// Get disabled color
  static Color disabled(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFD1D5DB)
      : const Color(0xFF6B7280);

  /// Get disabled background color
  static Color disabledBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFF3F4F6)
      : const Color(0xFF374151);
}
