import 'package:flutter/material.dart';
import '../../design_tokens/colors.dart';
import '../../design_tokens/spacing.dart';
import '../../design_tokens/radius.dart';

class DSCard extends StatelessWidget {
  const DSCard({
    super.key,
    this.title,
    required this.child,
    this.elevation = 0,
    this.onTap,
    this.enabled = true,
    this.padding,
    this.semanticLabel,
    this.backgroundColor,
  });

  final Widget? title;
  final Widget child;
  final double elevation;
  final VoidCallback? onTap;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final String? semanticLabel;
  final Color? backgroundColor;

  void _handleTap() {
    if (!enabled || onTap == null) return;
    onTap!();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: onTap != null,
      child: GestureDetector(
        onTap: enabled ? _handleTap : null,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? DSColors.surface(context),
            borderRadius: BorderRadius.circular(DSRadius.card),
            boxShadow: elevation > 0
                ? [
                    BoxShadow(
                      color: DSColors.border(context).withOpacity(0.1),
                      blurRadius: elevation,
                      offset: Offset(0, elevation),
                    ),
                  ]
                : null,
            border: Border.all(color: DSColors.border(context)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.all(DSSpacing.paddingMedium),
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.titleMedium!,
                    child: title!,
                  ),
                ),
              Padding(
                padding:
                    padding ?? const EdgeInsets.all(DSSpacing.paddingMedium),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
