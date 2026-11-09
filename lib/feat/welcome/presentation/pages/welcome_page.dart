import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import '../cubit/welcome_cubit.dart';
import '../cubit/welcome_state.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isArabic = context.locale.languageCode == 'ar';
    final platformBrightness = MediaQuery.platformBrightnessOf(context);
    final themeMode = context.watch<ThemeCubit>().state;
    final isDark = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            platformBrightness == Brightness.dark);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Text(
                'app_name'.tr(),
                textAlign: TextAlign.center,
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: isArabic ? 0 : -0.5,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'welcome.tagline'.tr(),
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: isArabic ? 0 : null,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'welcome.promise'.tr(),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                  letterSpacing: isArabic ? 0 : null,
                ),
              ),
              SizedBox(height: 40.h),
              AppButton(
                label: 'welcome.primary_action'.tr(),
                variant: AppButtonVariant.primary,
                onPressed: () => context.read<WelcomeCubit>().onPrimaryPressed(),
              ),
              SizedBox(height: 12.h),
              AppButton(
                label: 'welcome.secondary_action'.tr(),
                variant: AppButtonVariant.secondary,
                onPressed: () =>
                    context.read<WelcomeCubit>().onSecondaryPressed(),
              ),
              SizedBox(height: 12.h),
              AppButton(
                label: 'welcome.tertiary_action'.tr(),
                variant: AppButtonVariant.tertiary,
                onPressed: () =>
                    context.read<WelcomeCubit>().onTertiaryPressed(),
              ),
              SizedBox(height: 24.h),
              AppButton(
                label: 'welcome.toggle_language'.tr(),
                variant: AppButtonVariant.secondary,
                onPressed: () => _toggleLanguage(context),
              ),
              SizedBox(height: 12.h),
              AppButton(
                label: isDark
                    ? 'welcome.toggle_theme_light'.tr()
                    : 'welcome.toggle_theme_dark'.tr(),
                variant: AppButtonVariant.secondary,
                onPressed: () => context
                    .read<ThemeCubit>()
                    .toggle(platformBrightness),
              ),
              SizedBox(height: 12.h),
              AppButton(
                label: 'welcome.open_showcase'.tr(),
                variant: AppButtonVariant.primary,
                onPressed: () => context.push(AppRoutes.widgetsShowcase),
              ),
              SizedBox(height: 24.h),
              BlocBuilder<WelcomeCubit, WelcomeState>(
                builder: (context, state) {
                  final message = state.lastAction == null
                      ? 'welcome.no_action'.tr()
                      : 'welcome.last_action'.tr(
                          namedArgs: {
                            'action': _actionLabel(state.lastAction!),
                          },
                        );

                  return Text(
                    message,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  );
                },
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggleLanguage(BuildContext context) async {
    final next = context.locale.languageCode == 'ar'
        ? const Locale('en')
        : const Locale('ar');
    await context.setLocale(next);
  }

  String _actionLabel(AppButtonVariant variant) {
    return switch (variant) {
      AppButtonVariant.primary => 'welcome.primary_action'.tr(),
      AppButtonVariant.secondary => 'welcome.secondary_action'.tr(),
      AppButtonVariant.tertiary => 'welcome.tertiary_action'.tr(),
    };
  }
}
