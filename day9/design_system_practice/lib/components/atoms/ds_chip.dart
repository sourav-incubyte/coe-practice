import 'package:flutter/material.dart';
import '../../design_tokens/colors.dart';
import '../../design_tokens/spacing.dart';
import '../../design_tokens/typography.dart';
import '../../design_tokens/radius.dart';

enum DSChipSize { small, medium, large }

class DSChip extends StatelessWidget {
  const DSChip({
    super.key,
    this.label,
    this.selected = false,
    this.size = DSChipSize.medium,
    this.icon,
    this.onTap,
    this.onSelected,
    this.enabled = true,
    this.semanticLabel,
    this.child,
  });

  final String? label;
  final bool selected;
  final DSChipSize size;
  final Widget? icon;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onSelected;
  final bool enabled;
  final String? semanticLabel;
  final Widget? child;

  Color _getBackgroundColor(BuildContext context) {
    if (!enabled) return DSColors.disabledBackground(context);
    if (selected) return DSColors.primary(context);
    return DSColors.backgroundSecondary(context);
  }

  Color _getTextColor(BuildContext context) {
    if (!enabled) return DSColors.disabled(context);
    if (selected) return DSColors.textInverse(context);
    return DSColors.textPrimary(context);
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case DSChipSize.small:
        return DSTypography.labelSmall;
      case DSChipSize.medium:
        return DSTypography.labelMedium;
      case DSChipSize.large:
        return DSTypography.labelLarge;
    }
  }

  double _getPadding() {
    switch (size) {
      case DSChipSize.small:
        return DSSpacing.paddingSmall;
      case DSChipSize.medium:
        return DSSpacing.paddingMedium;
      case DSChipSize.large:
        return DSSpacing.paddingLarge;
    }
  }

  void _handleTap() {
    if (!enabled) return;
    if (onTap != null) {
      onTap!();
    } else if (onSelected != null) {
      onSelected!(!selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: semanticLabel,
      child: InkWell(
        onTap: enabled ? _handleTap : null,
        borderRadius: BorderRadius.circular(DSRadius.chip),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _getPadding(),
            vertical: _getPadding() * 0.5,
          ),
          decoration: BoxDecoration(
            color: _getBackgroundColor(context),
            borderRadius: BorderRadius.circular(DSRadius.chip),
            border: Border.all(
              color: selected
                  ? DSColors.primary(context)
                  : DSColors.border(context),
              width: selected ? 2 : 1,
            ),
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
      ),
    );
  }
}
