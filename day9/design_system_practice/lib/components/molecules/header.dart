import 'package:flutter/material.dart';
import '../../design_tokens/colors.dart';
import '../../design_tokens/spacing.dart';
import '../../design_tokens/typography.dart';

enum HeaderVariant { titleOnly, titleWithCTA, titleWithIcon }

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.variant,
    required this.title,
    this.subtitle,
    this.cta,
    this.icon,
    this.actions,
    this.onActionTap,
    this.onIconTap,
    this.semanticLabel,
  });

  final HeaderVariant variant;
  final Widget title;
  final Widget? subtitle;
  final Widget? cta;
  final Widget? icon;
  final List<Widget>? actions;
  final VoidCallback? onActionTap;
  final VoidCallback? onIconTap;
  final String? semanticLabel;

  factory Header.titleOnly({
    Key? key,
    required Widget title,
    Widget? subtitle,
    List<Widget>? actions,
    String? semanticLabel,
  }) {
    return Header(
      key: key,
      variant: HeaderVariant.titleOnly,
      title: title,
      subtitle: subtitle,
      actions: actions,
      semanticLabel: semanticLabel,
    );
  }

  factory Header.titleWithCTA({
    Key? key,
    required Widget title,
    required Widget cta,
    VoidCallback? onActionTap,
    Widget? subtitle,
    List<Widget>? actions,
    String? semanticLabel,
  }) {
    return Header(
      key: key,
      variant: HeaderVariant.titleWithCTA,
      title: title,
      cta: cta,
      onActionTap: onActionTap,
      subtitle: subtitle,
      actions: actions,
      semanticLabel: semanticLabel,
    );
  }

  factory Header.titleWithIcon({
    Key? key,
    required Widget title,
    required Widget icon,
    VoidCallback? onIconTap,
    Widget? subtitle,
    List<Widget>? actions,
    String? semanticLabel,
  }) {
    return Header(
      key: key,
      variant: HeaderVariant.titleWithIcon,
      title: title,
      icon: icon,
      onIconTap: onIconTap,
      subtitle: subtitle,
      actions: actions,
      semanticLabel: semanticLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      header: true,
      child: Container(
        padding: const EdgeInsets.all(DSSpacing.paddingLarge),
        decoration: BoxDecoration(
          color: DSColors.surface(context),
          border: Border(bottom: BorderSide(color: DSColors.border(context))),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (variant == HeaderVariant.titleWithIcon && icon != null) ...[
                  GestureDetector(onTap: onIconTap, child: icon),
                  const SizedBox(width: DSSpacing.md),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultTextStyle(style: DSTypography.h4, child: title),
                      if (subtitle != null) ...[
                        const SizedBox(height: DSSpacing.xs),
                        DefaultTextStyle(
                          style: DSTypography.bodyMedium.copyWith(
                            color: DSColors.textSecondary(context),
                          ),
                          child: subtitle!,
                        ),
                      ],
                    ],
                  ),
                ),
                if (variant == HeaderVariant.titleWithCTA && cta != null) ...[
                  const SizedBox(width: DSSpacing.md),
                  GestureDetector(onTap: onActionTap, child: cta),
                ],
                if (actions != null && actions!.isNotEmpty) ...[
                  const SizedBox(width: DSSpacing.md),
                  Row(mainAxisSize: MainAxisSize.min, children: actions!),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
