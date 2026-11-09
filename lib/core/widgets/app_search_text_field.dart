import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSearchTextField extends StatelessWidget {
  const AppSearchTextField({
    super.key,
    required this.hint,
    this.secureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.controller,
    this.validator,
    this.autofillHints,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.withBorder = true,
    this.helperText,
    this.onTap,
    this.onChanged,
    this.focusNode,
    this.onSubmit,
    this.onTapOutside,
    this.borderRadius,
    this.padding,
    this.hintStyle,
    this.style,
  });

  final String hint;
  final bool secureText, enabled, readOnly, withBorder;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final Color? fillColor;
  final Widget? prefixIcon, suffixIcon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final String? helperText;
  final FocusNode? focusNode;
  final VoidCallback? onSubmit;
  final TapRegionCallback? onTapOutside;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? hintStyle;
  final TextStyle? style;

  BorderRadius _resolvedBorderRadius(BuildContext context) {
    return (borderRadius ?? BorderRadius.circular(999.r)).resolve(
      Directionality.of(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final resolvedBorderRadius = _resolvedBorderRadius(context);

    return Column(
      spacing: 12.sp,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: focusNode,
          controller: controller,
          obscureText: secureText,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          enabled: enabled,
          validator: validator,
          autocorrect: false,
          autofillHints: autofillHints,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          onTapOutside: onTapOutside,
          onEditingComplete: onSubmit,
          style: style ?? theme.textTheme.titleSmall,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ?? colorScheme.surface,
            contentPadding: padding ??
                EdgeInsetsDirectional.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
            border: OutlineInputBorder(
              borderRadius: resolvedBorderRadius,
              borderSide: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.5),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: resolvedBorderRadius,
              borderSide: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: resolvedBorderRadius,
              borderSide: BorderSide(color: colorScheme.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: resolvedBorderRadius,
              borderSide: BorderSide(color: colorScheme.error),
            ),
            hintText: hint,
            hintStyle: hintStyle ??
                theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            prefixIconConstraints: BoxConstraints(
              minWidth: 16.w,
              minHeight: 16.h,
            ),
            isDense: true,
          ),
        ),
        if (helperText != null)
          Text(
            helperText!,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 11.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}
