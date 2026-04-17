import 'package:flutter/material.dart';
import '../../design_tokens/colors.dart';
import '../../design_tokens/spacing.dart';
import '../../design_tokens/typography.dart';
import '../../design_tokens/radius.dart';

enum DSButtonVariant { primary, secondary, ghost }

enum DSButtonSize { small, medium, large }

class DSButton extends StatelessWidget {
  const DSButton({
    super.key,
    required this.variant,
    required this.onPressed,
    required this.child,
    this.size = DSButtonSize.medium,
    this.fullWidth = false,
    this.enabled = true,
    this.semanticLabel,
  });

  final DSButtonVariant variant;
  final VoidCallback? onPressed;
  final Widget child;
  final DSButtonSize size;
  final bool fullWidth;
  final bool enabled;
  final String? semanticLabel;

  factory DSButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    DSButtonSize size = DSButtonSize.medium,
    bool fullWidth = false,
    bool enabled = true,
    String? semanticLabel,
  }) {
    return DSButton(
      key: key,
      variant: DSButtonVariant.primary,
      onPressed: onPressed,
      child: child,
      size: size,
      fullWidth: fullWidth,
      enabled: enabled,
      semanticLabel: semanticLabel,
    );
  }

  factory DSButton.secondary({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    DSButtonSize size = DSButtonSize.medium,
    bool fullWidth = false,
    bool enabled = true,
    String? semanticLabel,
  }) {
    return DSButton(
      key: key,
      variant: DSButtonVariant.secondary,
      onPressed: onPressed,
      child: child,
      size: size,
      fullWidth: fullWidth,
      enabled: enabled,
      semanticLabel: semanticLabel,
    );
  }

  factory DSButton.ghost({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    DSButtonSize size = DSButtonSize.medium,
    bool fullWidth = false,
    bool enabled = true,
    String? semanticLabel,
  }) {
    return DSButton(
      key: key,
      variant: DSButtonVariant.ghost,
      onPressed: onPressed,
      child: child,
      size: size,
      fullWidth: fullWidth,
      enabled: enabled,
      semanticLabel: semanticLabel,
    );
  }

  double _getPadding() {
    switch (size) {
      case DSButtonSize.small:
        return DSSpacing.paddingSmall;
      case DSButtonSize.medium:
        return DSSpacing.paddingMedium;
      case DSButtonSize.large:
        return DSSpacing.paddingLarge;
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case DSButtonSize.small:
        return DSTypography.labelSmall;
      case DSButtonSize.medium:
        return DSTypography.labelMedium;
      case DSButtonSize.large:
        return DSTypography.labelLarge;
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    if (!enabled) return DSColors.disabledBackground(context);

    switch (variant) {
      case DSButtonVariant.primary:
        return DSColors.primary(context);
      case DSButtonVariant.secondary:
        return DSColors.secondary(context);
      case DSButtonVariant.ghost:
        return Colors.transparent;
    }
  }

  Color _getTextColor(BuildContext context) {
    if (!enabled) return DSColors.disabled(context);

    switch (variant) {
      case DSButtonVariant.primary:
      case DSButtonVariant.secondary:
        return DSColors.textInverse(context);
      case DSButtonVariant.ghost:
        return DSColors.primary(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: SizedBox(
        width: fullWidth ? double.infinity : null,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _getBackgroundColor(context),
            foregroundColor: _getTextColor(context),
            disabledBackgroundColor: DSColors.disabledBackground(context),
            disabledForegroundColor: DSColors.disabled(context),
            padding: EdgeInsets.symmetric(
              horizontal: _getPadding(),
              vertical: _getPadding(),
            ),
            textStyle: _getTextStyle(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DSRadius.buttonMedium),
            ),
            elevation: 0,
          ),
          child: child,
        ),
      ),
    );
  }
}
