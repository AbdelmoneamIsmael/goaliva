import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color, this.loadingSize});

  final Color? color;
  final double? loadingSize;

  @override
  Widget build(BuildContext context) {
    final size = loadingSize ?? 24.sp;
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
