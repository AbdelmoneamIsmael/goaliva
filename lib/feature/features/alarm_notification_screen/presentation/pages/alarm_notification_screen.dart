import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:goaliva/core/models/alarm/alarm.dart';
import 'package:goaliva/core/theme/app_colors.dart';
import 'package:goaliva/core/theme/app_toast.dart';
import 'package:goaliva/core/widgets/app_button.dart';
import 'package:goaliva/feature/features/alarm_notification_screen/presentation/cubit/alarm_notification_screen_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';

class AlarmNotificationScreen extends StatelessWidget {
  const AlarmNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      AlarmNotificationScreenCubit,
      AlarmNotificationScreenState
    >(
      listener: (context, state) {
        switch (state) {
          case AlarmNotificationScreenCompleted():
            if (context.canPop()) {
              context.pop();
            }
          case AlarmNotificationScreenFailure(:final message):
            AppToast.show(
              context,
              'alarm.toast_error'.tr(),
              type: ToastificationType.error,
              description: message,
            );
          default:
            break;
        }
      },
      builder: (context, state) {
        final alarm = switch (state) {
          AlarmNotificationScreenReady(:final alarm) => alarm,
          AlarmNotificationScreenBusy(:final alarm) => alarm,
          _ => null,
        };
        final isBusy = state is AlarmNotificationScreenBusy;
        final isLoading = state is AlarmNotificationScreenLoading;

        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          body: Stack(
            fit: StackFit.expand,
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: const Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(color: AppColors.darkBackground),
                    _SlowIncenseSmoke(),
                  ],
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.darkBackground.withValues(alpha: 0.35),
                      AppColors.darkBackground.withValues(alpha: 0.55),
                      AppColors.darkBackground.withValues(alpha: 0.85),
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.darkPrimary,
                          ),
                        )
                      : _AlarmRingContent(
                          alarm: alarm,
                          isBusy: isBusy,
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Full-bleed incense smoke played at half speed for a slow, calm drift.
class _SlowIncenseSmoke extends StatefulWidget {
  const _SlowIncenseSmoke();

  @override
  State<_SlowIncenseSmoke> createState() => _SlowIncenseSmokeState();
}

class _SlowIncenseSmokeState extends State<_SlowIncenseSmoke>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/relax_smoke.json',
      controller: _controller,
      fit: BoxFit.cover,
      onLoaded: (composition) {
        _controller
          ..duration = composition.duration * 2.2
          ..repeat();
      },
    );
  }
}

class _AlarmRingContent extends StatelessWidget {
  const _AlarmRingContent({
    required this.alarm,
    required this.isBusy,
  });

  final AlarmModel? alarm;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final title = (alarm?.title.isNotEmpty ?? false)
        ? alarm!.title
        : 'alarm.ring_fallback_title'.tr();
    final description = (alarm?.description.isNotEmpty ?? false)
        ? alarm!.description
        : 'alarm.ring_fallback_body'.tr();

    return Column(
      children: [
        const Spacer(flex: 2),
        Text(
          'alarm.ring_headline'.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.darkTextPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.darkPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.darkTextSecondary,
          ),
        ),
        const Spacer(flex: 3),
        AppButton(
          label: 'alarm.snooze_5'.tr(),
          onPressed: isBusy
              ? null
              : () => context.read<AlarmNotificationScreenCubit>().snooze(),
          variant: AppButtonVariant.secondary,
        ),
        SizedBox(height: 12.h),
        AppButton(
          label: 'alarm.dismiss'.tr(),
          onPressed: isBusy
              ? null
              : () => context.read<AlarmNotificationScreenCubit>().dismiss(),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
