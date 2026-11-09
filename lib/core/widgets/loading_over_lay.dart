import 'dart:ui';

import 'package:flutter/material.dart';

import 'loading.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: ColoredBox(
        color: Colors.black.withValues(alpha: 0.55),
        child: const Center(
          child: LoadingWidget(color: Colors.white, loadingSize: 32),
        ),
      ),
    );
  }
}
