import 'package:flutter/material.dart';
import '../../design_tokens/colors.dart';
import '../../design_tokens/spacing.dart';
import '../../design_tokens/typography.dart';
import '../../design_tokens/radius.dart';

class DSTextField extends StatelessWidget {
  const DSTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.errorText,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.focusNode,
    this.semanticLabel,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String? hintText;
  final String? errorText;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final String? semanticLabel;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      textField: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: DSTypography.labelMedium.copyWith(
              color: enabled
                  ? DSColors.textPrimary(context)
                  : DSColors.textSecondary(context),
            ),
          ),
          const SizedBox(height: DSSpacing.xs),
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            enabled: enabled,
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: enabled
                  ? DSColors.backgroundSecondary(context)
                  : DSColors.disabledBackground(context),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DSRadius.input),
                borderSide: BorderSide(color: DSColors.border(context)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DSRadius.input),
                borderSide: BorderSide(color: DSColors.border(context)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DSRadius.input),
                borderSide: BorderSide(
                  color: DSColors.primary(context),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DSRadius.input),
                borderSide: BorderSide(color: DSColors.error),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DSRadius.input),
                borderSide: BorderSide(color: DSColors.error, width: 2),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DSRadius.input),
                borderSide: BorderSide(color: DSColors.borderLight(context)),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: DSSpacing.paddingMedium,
                vertical: DSSpacing.paddingMedium,
              ),
            ),
            style: DSTypography.bodyMedium.copyWith(
              color: enabled
                  ? DSColors.textPrimary(context)
                  : DSColors.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }
}
