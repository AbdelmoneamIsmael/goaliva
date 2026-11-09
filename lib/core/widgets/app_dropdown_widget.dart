import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Styled dropdown that opens a custom menu below the trigger field.
class CustomDropdown<T> extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.value,
    this.hint = 'Select',
    this.enabled = true,
  });

  final List<T> items;
  final String Function(T item) itemLabel;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String hint;
  final bool enabled;

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  static const _animationDuration = Duration(milliseconds: 200);
  static const _animationCurve = Curves.easeOutCubic;

  final _triggerKey = GlobalKey();
  bool _isOpen = false;

  Future<void> _openMenu() async {
    if (!widget.enabled || widget.items.isEmpty) return;

    final renderBox =
        _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero, ancestor: overlay);
    final size = renderBox.size;

    setState(() => _isOpen = true);

    final selected = await showMenu<T>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height + 9.h,
        offset.dx + size.width,
        offset.dy + size.height + 9.h,
      ),
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      constraints: BoxConstraints(minWidth: size.width, maxWidth: size.width),
      items: [
        PopupMenuItem<T>(
          padding: EdgeInsets.zero,
          child: _DropdownMenuPanel<T>(
            items: widget.items,
            itemLabel: widget.itemLabel,
            selectedValue: widget.value,
            onItemSelected: (item) => Navigator.pop(context, item),
          ),
        ),
      ],
    );

    if (mounted) {
      setState(() => _isOpen = false);
    }

    if (selected != null) {
      widget.onChanged(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasValue = widget.value != null;

    return Material(
      key: _triggerKey,
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: widget.enabled ? _openMenu : null,
        borderRadius: BorderRadius.circular(12.r),
        child: AnimatedContainer(
          duration: _animationDuration,
          curve: _animationCurve,
          height: 48.h,
          padding: EdgeInsetsDirectional.only(start: 15.w, end: 9.w),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _isOpen
                  ? colorScheme.primary
                  : colorScheme.outline.withValues(alpha: 0.5),
            ),
            boxShadow: _isOpen
                ? [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.25),
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Expanded(
                child: AnimatedDefaultTextStyle(
                  duration: _animationDuration,
                  curve: _animationCurve,
                  style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 13.sp,
                        height: 1,
                        color: hasValue
                            ? colorScheme.onSurface
                            : colorScheme.onSurfaceVariant,
                      ) ??
                      TextStyle(
                        fontSize: 13.sp,
                        color: hasValue
                            ? colorScheme.onSurface
                            : colorScheme.onSurfaceVariant,
                      ),
                  child: Text(
                    hasValue
                        ? widget.itemLabel(widget.value as T)
                        : widget.hint,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              AnimatedRotation(
                turns: _isOpen ? 0.5 : 0,
                duration: _animationDuration,
                curve: _animationCurve,
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18.w,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropdownMenuPanel<T> extends StatelessWidget {
  const _DropdownMenuPanel({
    required this.items,
    required this.itemLabel,
    required this.selectedValue,
    required this.onItemSelected,
  });

  final List<T> items;
  final String Function(T item) itemLabel;
  final T? selectedValue;
  final ValueChanged<T> onItemSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * -6),
            child: child,
          ),
        );
      },
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 12.w,
          vertical: 14.h,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0) SizedBox(height: 6.h),
              _DropdownMenuItem(
                label: itemLabel(items[i]),
                isSelected: items[i] == selectedValue,
                onTap: () => onItemSelected(items[i]),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DropdownMenuItem extends StatefulWidget {
  const _DropdownMenuItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_DropdownMenuItem> createState() => _DropdownMenuItemState();
}

class _DropdownMenuItemState extends State<_DropdownMenuItem> {
  static const _animationDuration = Duration(milliseconds: 150);
  static const _animationCurve = Curves.easeOutCubic;

  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final backgroundColor = widget.isSelected
        ? colorScheme.primary
        : _isHovered
            ? colorScheme.surfaceContainerHighest
            : Colors.transparent;
    final textColor =
        widget.isSelected ? colorScheme.onPrimary : colorScheme.onSurface;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: _animationDuration,
        curve: _animationCurve,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: widget.isSelected ? 36.h : 34.h,
              ),
              alignment: AlignmentDirectional.centerStart,
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 11.w,
                vertical: 10.h,
              ),
              child: AnimatedDefaultTextStyle(
                duration: _animationDuration,
                curve: _animationCurve,
                style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 14.sp,
                      height: 1,
                      color: textColor,
                    ) ??
                    TextStyle(fontSize: 14.sp, color: textColor),
                child: Text(widget.label),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
