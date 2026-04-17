import 'package:flutter/material.dart';
import '../../design_tokens/colors.dart';
import '../../design_tokens/spacing.dart';
import '../../design_tokens/typography.dart';
import '../../design_tokens/radius.dart';

class Accordion extends StatelessWidget {
  const Accordion({
    super.key,
    required this.title,
    required this.content,
    required this.expanded,
    required this.onExpandedChanged,
    this.icon,
    this.enabled = true,
    this.semanticLabel,
  });

  final Widget title;
  final Widget content;
  final bool expanded;
  final ValueChanged<bool> onExpandedChanged;
  final Widget? icon;
  final bool enabled;
  final String? semanticLabel;

  void _handleTap() {
    if (!enabled) return;
    onExpandedChanged(!expanded);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      expanded: expanded,
      button: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: _handleTap,
            borderRadius: BorderRadius.circular(DSRadius.card),
            child: Container(
              padding: const EdgeInsets.all(DSSpacing.paddingMedium),
              decoration: BoxDecoration(
                color: enabled
                    ? DSColors.surface(context)
                    : DSColors.disabledBackground(context),
                borderRadius: BorderRadius.circular(DSRadius.card),
                border: Border.all(color: DSColors.border(context)),
              ),
              child: Row(
                children: [
                  Expanded(child: title),
                  const SizedBox(width: DSSpacing.sm),
                  icon ??
                      AnimatedRotation(
                        turns: expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(Icons.expand_more),
                      ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            height: expanded ? null : 0,
            child: expanded
                ? Padding(
                    padding: const EdgeInsets.all(DSSpacing.paddingMedium),
                    child: content,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
