import 'package:flutter/material.dart';
import '../../design_tokens/colors.dart';
import '../../design_tokens/spacing.dart';
import '../../design_tokens/typography.dart';
import '../../design_tokens/radius.dart';

enum DSBadgeVariant { info, success, warning, error }

enum DSBadgeSize { small, medium, large }

class DSBadge extends StatelessWidget {
  const DSBadge({
    super.key,
    this.variant = DSBadgeVariant.info,
    this.label,
    this.size = DSBadgeSize.medium,
    this.semanticLabel,
    this.child,
    this.icon,
  });

  final DSBadgeVariant variant;
  final String? label;
  final DSBadgeSize size;
  final String? semanticLabel;
  final Widget? child;
  final Widget? icon;

  factory DSBadge.success({
    Key? key,
    required String label,
    DSBadgeSize size = DSBadgeSize.medium,
    String? semanticLabel,
    Widget? child,
    Widget? icon,
  }) {
    return DSBadge(
      key: key,
      variant: DSBadgeVariant.success,
      label: label,
      size: size,
      semanticLabel: semanticLabel,
      child: child,
      icon: icon,
    );
  }

  factory DSBadge.warning({
    Key? key,
    required String label,
    DSBadgeSize size = DSBadgeSize.medium,
    String? semanticLabel,
    Widget? child,
    Widget? icon,
  }) {
    return DSBadge(
      key: key,
      variant: DSBadgeVariant.warning,
      label: label,
      size: size,
      semanticLabel: semanticLabel,
      child: child,
      icon: icon,
    );
  }

  factory DSBadge.error({
    Key? key,
    required String label,
    DSBadgeSize size = DSBadgeSize.medium,
    String? semanticLabel,
    Widget? child,
    Widget? icon,
  }) {
    return DSBadge(
      key: key,
      variant: DSBadgeVariant.error,
      label: label,
      size: size,
      semanticLabel: semanticLabel,
      child: child,
      icon: icon,
    );
  }

  factory DSBadge.info({
    Key? key,
    required String label,
    DSBadgeSize size = DSBadgeSize.medium,
    String? semanticLabel,
    Widget? child,
    Widget? icon,
  }) {
    return DSBadge(
      key: key,
      variant: DSBadgeVariant.info,
      label: label,
      size: size,
      semanticLabel: semanticLabel,
      child: child,
      icon: icon,
    );
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case DSBadgeVariant.success:
        return DSColors.success;
      case DSBadgeVariant.warning:
        return DSColors.warning;
      case DSBadgeVariant.error:
        return DSColors.error;
      case DSBadgeVariant.info:
        return DSColors.info;
    }
  }

  Color _getTextColor(BuildContext context) {
    return DSColors.textInverse(context);
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case DSBadgeSize.small:
        return DSTypography.labelSmall;
      case DSBadgeSize.medium:
        return DSTypography.labelMedium;
      case DSBadgeSize.large:
        return DSTypography.labelLarge;
    }
  }

  double _getPadding() {
    switch (size) {
      case DSBadgeSize.small:
        return DSSpacing.paddingSmall;
      case DSBadgeSize.medium:
        return DSSpacing.paddingMedium;
      case DSBadgeSize.large:
        return DSSpacing.paddingLarge;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      container: true,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _getPadding(),
          vertical: _getPadding() * 0.5,
        ),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(DSRadius.chip),
        ),
        child:
            child ??
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  IconTheme(
                    data: IconThemeData(
                      color: _getTextColor(context),
                      size: _getTextStyle().fontSize,
                    ),
                    child: icon!,
                  ),
                  const SizedBox(width: DSSpacing.xs),
                ],
                if (label != null)
                  Text(
                    label!,
                    style: _getTextStyle().copyWith(
                      color: _getTextColor(context),
                    ),
                  ),
              ],
            ),
      ),
    );
  }
}
