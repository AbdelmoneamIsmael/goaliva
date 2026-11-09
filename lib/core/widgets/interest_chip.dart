import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InterestChip extends StatelessWidget {
  const InterestChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(color: colorScheme.primary),
        ),
        child: Center(
          widthFactor: 1,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16.sp,
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.primary,
                ),
          ),
        ),
      ),
    );
  }
}
