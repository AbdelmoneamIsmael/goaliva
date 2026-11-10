import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../widgets/settings_option_sheet.dart';
import '../widgets/settings_profile_card.dart';
import '../widgets/settings_section_card.dart';
import '../widgets/settings_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _remindersEnabled = true;
  bool _dailySparkEnabled = true;
  bool _goalCheckInsEnabled = false;
  bool _soundEnabled = true;

  String _themeLabel(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => 'settings.theme_light'.tr(),
      ThemeMode.dark => 'settings.theme_dark'.tr(),
      ThemeMode.system => 'settings.theme_system'.tr(),
    };
  }

  String _languageLabel(Locale locale) {
    return locale.languageCode == 'ar'
        ? 'settings.language_ar'.tr()
        : 'settings.language_en'.tr();
  }

  Future<void> _openAppearance() async {
    final cubit = context.read<ThemeCubit>();
    final selected = await showSettingsOptionSheet<ThemeMode>(
      context: context,
      title: 'settings.appearance'.tr(),
      selected: cubit.state,
      options: [
        SettingsOption(
          value: ThemeMode.system,
          label: 'settings.theme_system'.tr(),
        ),
        SettingsOption(
          value: ThemeMode.light,
          label: 'settings.theme_light'.tr(),
        ),
        SettingsOption(
          value: ThemeMode.dark,
          label: 'settings.theme_dark'.tr(),
        ),
      ],
    );
    if (selected == null || !mounted) return;
    await cubit.setThemeMode(selected);
  }

  Future<void> _openLanguage() async {
    final current = Locale(context.locale.languageCode);
    final selected = await showSettingsOptionSheet<Locale>(
      context: context,
      title: 'settings.language'.tr(),
      selected: current,
      options: [
        SettingsOption(
          value: const Locale('en'),
          label: 'settings.language_en'.tr(),
        ),
        SettingsOption(
          value: const Locale('ar'),
          label: 'settings.language_ar'.tr(),
        ),
      ],
    );
    if (selected == null || !mounted) return;
    await context.setLocale(selected);
  }

  void _onProfileTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('settings.profile_coming_soon'.tr()),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _openAbout() async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text('app_name'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'settings.about_body'.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'settings.about_version'.tr(namedArgs: {'version': '1.0.0'}),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('common.confirm'.tr()),
            ),
          ],
        );
      },
    );
  }

  Widget _sectionLabel(String key) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 4.w, bottom: 8.h),
      child: Text(
        key.tr(),
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final success = isDark ? AppColors.darkSuccess : AppColors.lightSuccess;
    final secondary =
        isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsetsDirectional.fromSTEB(20.w, 12.h, 20.w, 28.h),
          children: [
            Text(
              'settings.title'.tr(),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'settings.subtitle'.tr(),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            SizedBox(height: 24.h),
            SettingsProfileCard(onTap: _onProfileTap),
            SizedBox(height: 24.h),
            _sectionLabel('settings.section_notifications'),
            SettingsSectionCard(
              children: [
                SettingsSwitchTile(
                  icon: Icons.notifications_active_rounded,
                  title: 'settings.notif_reminders'.tr(),
                  subtitle: 'settings.notif_reminders_sub'.tr(),
                  value: _remindersEnabled,
                  accent: secondary,
                  onChanged: (value) =>
                      setState(() => _remindersEnabled = value),
                ),
                SettingsSwitchTile(
                  icon: Icons.auto_awesome_rounded,
                  title: 'settings.notif_spark'.tr(),
                  subtitle: 'settings.notif_spark_sub'.tr(),
                  value: _dailySparkEnabled,
                  onChanged: (value) =>
                      setState(() => _dailySparkEnabled = value),
                ),
                SettingsSwitchTile(
                  icon: Icons.flag_rounded,
                  title: 'settings.notif_goals'.tr(),
                  subtitle: 'settings.notif_goals_sub'.tr(),
                  value: _goalCheckInsEnabled,
                  accent: success,
                  onChanged: (value) =>
                      setState(() => _goalCheckInsEnabled = value),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            _sectionLabel('settings.section_preferences'),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return SettingsSectionCard(
                  children: [
                    SettingsTile(
                      icon: Icons.palette_rounded,
                      title: 'settings.appearance'.tr(),
                      subtitle: _themeLabel(themeMode),
                      onTap: _openAppearance,
                    ),
                    SettingsTile(
                      icon: Icons.language_rounded,
                      title: 'settings.language'.tr(),
                      subtitle: _languageLabel(context.locale),
                      accent: secondary,
                      onTap: _openLanguage,
                    ),
                    SettingsSwitchTile(
                      icon: Icons.volume_up_rounded,
                      title: 'settings.sound'.tr(),
                      subtitle: 'settings.sound_sub'.tr(),
                      value: _soundEnabled,
                      accent: success,
                      onChanged: (value) =>
                          setState(() => _soundEnabled = value),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20.h),
            _sectionLabel('settings.section_about'),
            SettingsSectionCard(
              children: [
                SettingsTile(
                  icon: Icons.info_outline_rounded,
                  title: 'settings.about'.tr(),
                  subtitle: 'settings.about_sub'.tr(),
                  onTap: _openAbout,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
