import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFieldWithTitle extends StatelessWidget {
  const AppTextFieldWithTitle({
    this.onSubmit,
    this.onTapOutside,
    this.onTap,
    super.key,
    required this.title,
    required this.hint,
    this.secureText = false,
    this.enabled = true,
    this.onChanged,
    this.focusNode,
    this.readOnly = false,
    this.controller,
    this.validator,
    this.autofillHints,
    this.inputFormatters,
    this.keyboardType,
    this.maxLines = 1,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.isRequired = false,
    this.helperText,
    this.validationHint = '',
    this.textInputAction,
  });

  final String title, hint;
  final String? helperText;
  final bool secureText, enabled, readOnly;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final Widget? prefixIcon, suffixIcon;
  final void Function(String)? onChanged;
  final bool isRequired;
  final String? validationHint;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final VoidCallback? onSubmit;
  final TapRegionCallback? onTapOutside;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: theme.textTheme.titleSmall),
            if (isRequired)
              Text(
                '*',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
          ],
        ),
        SizedBox(height: 11.h),
        AppTextField(
          focusNode: focusNode,
          onSubmit: onSubmit,
          onTapOutside: onTapOutside,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hint: hint,
          onTap: onTap,
          secureText: secureText,
          enabled: enabled,
          readOnly: readOnly,
          controller: controller,
          validator: validator,
          autofillHints: autofillHints,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          onChanged: onChanged,
          helperText: helperText,
          fillColor: fillColor,
        ),
      ],
    );
  }
}

class AppTextField extends StatefulWidget {
  const AppTextField({
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
    this.helperTextFontSize,
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
  final double? helperTextFontSize;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.secureText;
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.secureText != widget.secureText) {
      _obscureText = widget.secureText;
    }
  }

  Widget? get _suffixIcon {
    if (widget.secureText) {
      final colorScheme = Theme.of(context).colorScheme;
      return IconButton(
        onPressed: () => setState(() => _obscureText = !_obscureText),
        tooltip: _obscureText
            ? 'common.show_password'.tr()
            : 'common.hide_password'.tr(),
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: colorScheme.onSurfaceVariant,
        ),
      );
    }
    return widget.suffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final fill = widget.fillColor ??
        (isDark ? colorScheme.surface : colorScheme.surface);
    final radius = BorderRadius.circular(12.r);

    return Column(
      spacing: 12.sp,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          obscureText: _obscureText,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          validator: widget.validator,
          autocorrect: false,
          autofillHints: widget.autofillHints,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          maxLines: widget.maxLines,
          onTapOutside: widget.onTapOutside,
          onEditingComplete: widget.onSubmit,
          style: theme.textTheme.titleSmall,
          decoration: InputDecoration(
            filled: true,
            fillColor: fill,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            hintText: widget.hint,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: _suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(color: colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(color: colorScheme.error, width: 1.5),
            ),
          ),
        ),
        if (widget.helperText != null)
          Text(
            widget.helperText!,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: widget.helperTextFontSize ?? 11.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}
