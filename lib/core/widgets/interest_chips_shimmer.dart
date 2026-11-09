import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InterestChipsShimmer extends StatefulWidget {
  const InterestChipsShimmer({super.key});

  @override
  State<InterestChipsShimmer> createState() => _InterestChipsShimmerState();
}

class _InterestChipsShimmerState extends State<InterestChipsShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final widths = [88.0, 140.0, 120.0, 72.0, 110.0, 130.0, 96.0, 150.0];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        final base = colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.35 + (t * 0.35),
        );
        return Wrap(
          spacing: 5.w,
          runSpacing: 8.h,
          children: [
            for (var i = 0; i < widths.length; i++)
              Container(
                height: 44.h,
                width: widths[i].w,
                decoration: BoxDecoration(
                  color: base,
                  borderRadius: BorderRadius.circular(999.r),
                ),
              ),
          ],
        );
      },
    );
  }
}
