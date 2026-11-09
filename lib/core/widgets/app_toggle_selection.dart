import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToggleItem {
  const ToggleItem({required this.label, this.icon});

  final String label;
  final Widget? icon;
}

class AppToggleSelectionWidget extends StatefulWidget {
  const AppToggleSelectionWidget({
    super.key,
    required this.first,
    required this.second,
    required this.onChanged,
    this.initialIndex = 0,
    this.margin,
  }) : assert(initialIndex == 0 || initialIndex == 1);

  final ToggleItem first;
  final ToggleItem second;
  final ValueChanged<int> onChanged;
  final int initialIndex;
  final EdgeInsetsGeometry? margin;

  @override
  State<AppToggleSelectionWidget> createState() =>
      _AppToggleSelectionWidgetState();
}

class _AppToggleSelectionWidgetState extends State<AppToggleSelectionWidget> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onSegmentTap(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isFirstSelected = _selectedIndex == 0;

    return Container(
      margin: widget.margin ??
          EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final halfWidth = constraints.maxWidth / 2;

          return Stack(
            children: [
              AnimatedPositionedDirectional(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                start: isFirstSelected ? 0 : halfWidth,
                top: 0,
                bottom: 0,
                width: halfWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _ToggleSegment(
                      label: widget.first.label,
                      icon: widget.first.icon,
                      isSelected: isFirstSelected,
                      onTap: () => _onSegmentTap(0),
                    ),
                  ),
                  Expanded(
                    child: _ToggleSegment(
                      label: widget.second.label,
                      icon: widget.second.icon,
                      isSelected: !isFirstSelected,
                      onTap: () => _onSegmentTap(1),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ToggleSegment extends StatelessWidget {
  const _ToggleSegment({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final Widget? icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selectedColor = colorScheme.onPrimary;
    final idleColor = colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  isSelected ? selectedColor : idleColor,
                  BlendMode.srcIn,
                ),
                child: icon,
              ),
              SizedBox(width: 6.w),
            ],
            Flexible(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      height: 1.4,
                      color: isSelected ? selectedColor : idleColor,
                    ) ??
                    TextStyle(
                      fontSize: 12.sp,
                      color: isSelected ? selectedColor : idleColor,
                    ),
                child: FittedBox(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
