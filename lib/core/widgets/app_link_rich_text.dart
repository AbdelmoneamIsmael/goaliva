import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLinkRichText extends StatefulWidget {
  const AppLinkRichText({
    super.key,
    required this.leadingText,
    required this.linkText,
    required this.onLinkTap,
    this.textAlign = TextAlign.center,
    this.leadingStyle,
    this.linkStyle,
  });

  final String leadingText;
  final String linkText;
  final VoidCallback onLinkTap;
  final TextAlign textAlign;
  final TextStyle? leadingStyle;
  final TextStyle? linkStyle;

  @override
  State<AppLinkRichText> createState() => _AppLinkRichTextState();
}

class _AppLinkRichTextState extends State<AppLinkRichText> {
  late final TapGestureRecognizer _linkTap = TapGestureRecognizer();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _linkTap.onTap = widget.onLinkTap;
  }

  @override
  void didUpdateWidget(AppLinkRichText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.onLinkTap != widget.onLinkTap) {
      _linkTap.onTap = widget.onLinkTap;
    }
  }

  @override
  void dispose() {
    _linkTap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final leadingStyle = widget.leadingStyle ??
        theme.textTheme.bodyMedium?.copyWith(fontSize: 15.sp);
    final linkStyle = widget.linkStyle ??
        theme.textTheme.titleSmall?.copyWith(
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
          color: colorScheme.primary,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.solid,
          decorationColor: colorScheme.primary,
        );

    return RichText(
      textAlign: widget.textAlign,
      text: TextSpan(
        children: [
          TextSpan(text: widget.leadingText, style: leadingStyle),
          TextSpan(
            text: widget.linkText,
            style: linkStyle,
            recognizer: _linkTap,
          ),
        ],
      ),
    );
  }
}
