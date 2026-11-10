import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_week_calendar.dart';
import '../../../alarm/presentation/cubit/alarm_cubit.dart';
import '../../../alarm/presentation/pages/alarm_page.dart';
import '../cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isArabic = context.locale.languageCode == 'ar';

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            bottom: false,
            child: ListView(
              padding: EdgeInsetsDirectional.fromSTEB(20.w, 12.h, 20.w, 28.h),
              children: [
                _HeroHeader(isArabic: isArabic, isDark: isDark),
                SizedBox(height: 22.h),
                AppWeekCalendar(
                  title: 'home.momentum_title'.tr(),
                  statusText: 'home.momentum_status'.tr(),
                  focusedDay: state.focusedDay,
                  selectedDay: state.selectedDay,
                  completedDays: state.completedDays,
                  onDaySelected: (selected, focused) {
                    context.read<HomeCubit>().selectDay(selected, focused);
                  },
                  onPageChanged: (focused) {
                    context.read<HomeCubit>().changeWeek(focused);
                  },
                ),
                SizedBox(height: 22.h),
                _QuickGrid(isDark: isDark),
                SizedBox(height: 22.h),
                _TodayMotivationCard(isDark: isDark),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Gradient hero card combining brand bar, greeting, and streak.
class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.isArabic, required this.isDark});

  final bool isArabic;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final secondary = isDark
        ? AppColors.darkSecondary
        : AppColors.lightSecondary;

    return ClipRRect(
      borderRadius: BorderRadius.circular(28.r),
      child: Container(
        padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 20.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [colorScheme.primary, secondary],
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(
                alpha: isDark ? 0.35 : 0.28,
              ),
              blurRadius: 28,
              offset: Offset(0, 14.h),
            ),
          ],
        ),
        child: Stack(
          children: [
            PositionedDirectional(
              top: -30.h,
              end: -20.w,
              child: _GlowCircle(size: 140.w),
            ),
            PositionedDirectional(
              bottom: -40.h,
              start: -30.w,
              child: _GlowCircle(size: 120.w),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _GlassBadge(
                      size: 38.w,
                      child: Icon(
                        Icons.gps_fixed_rounded,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'app_name'.tr(),
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'home.brand_subtitle'.tr(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _GlassBadge(
                          size: 38.w,
                          child: Icon(
                            Icons.notifications_none_rounded,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                        PositionedDirectional(
                          top: -1,
                          end: -1,
                          child: Container(
                            width: 9.w,
                            height: 9.w,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkSuccess
                                  : AppColors.lightSuccess,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      width: 38.w,
                      height: 38.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.18),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'A',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'home.greeting'.tr()),
                      TextSpan(text: ' ${'home.greeting_wave'.tr()}'),
                    ],
                  ),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: isArabic ? 0 : -0.3,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'home.motto'.tr(),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 14.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(999.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('🔥', style: TextStyle(fontSize: 13.sp)),
                        SizedBox(width: 6.w),
                        Text(
                          'home.streak'.tr(),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassBadge extends StatelessWidget {
  const _GlassBadge({required this.size, required this.child});

  final double size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(size * 0.32),
        border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.08),
      ),
    );
  }
}

class _QuickGrid extends StatelessWidget {
  const _QuickGrid({required this.isDark});

  final bool isDark;

  Future<void> _openAlarms(BuildContext context) async {
    final cubit = context.read<AlarmCubit>();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            BlocProvider.value(value: cubit, child: const AlarmPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final success = isDark ? AppColors.darkSuccess : AppColors.lightSuccess;
    final secondary = isDark
        ? AppColors.darkSecondary
        : AppColors.lightSecondary;

    return BlocBuilder<AlarmCubit, AlarmState>(
      builder: (context, alarmState) {
        final tiles = [
          (
            Icons.alarm_rounded,
            'home.grid_alarms'.tr(),
            'home.grid_alarms_count'.tr(
              namedArgs: {'count': '${alarmState.activeCount}'},
            ),
            secondary,
            () => _openAlarms(context),
          ),
          (
            Icons.event_rounded,
            'home.grid_events'.tr(),
            'home.grid_events_count'.tr(),
            colorScheme.primary,
            null,
          ),
          (
            Icons.checklist_rounded,
            'home.grid_tasks'.tr(),
            'home.grid_tasks_count'.tr(),
            success,
            null,
          ),
          (
            Icons.flag_rounded,
            'home.grid_goals'.tr(),
            'home.grid_goals_count'.tr(),
            colorScheme.primary,
            null,
          ),
        ];

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tiles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14.h,
            crossAxisSpacing: 14.w,
            childAspectRatio: 1.3,
          ),
          itemBuilder: (context, index) {
            final tile = tiles[index];
            return _QuickGridTile(
              icon: tile.$1,
              title: tile.$2,
              subtitle: tile.$3,
              accent: tile.$4,
              isDark: isDark,
              onTap: tile.$5,
            );
          },
        );
      },
    );
  }
}

class _QuickGridTile extends StatelessWidget {
  const _QuickGridTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.isDark,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final bool isDark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
            ),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: isDark ? 0.18 : 0.12),
                blurRadius: 18,
                offset: Offset(0, 8.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      accent.withValues(alpha: isDark ? 0.9 : 1),
                      accent.withValues(alpha: isDark ? 0.55 : 0.65),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(icon, color: Colors.white, size: 21.sp),
              ),
              const Spacer(),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodayMotivationCard extends StatelessWidget {
  const _TodayMotivationCard({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'home.today_motivation_label'.tr(),
          style: theme.textTheme.titleSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(22.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [
                  colorScheme.primary.withValues(alpha: isDark ? 0.3 : 0.16),
                  isDark ? AppColors.darkSurface : AppColors.lightSurface,
                ],
              ),
              border: Border.all(
                color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
              ),
            ),
            child: Stack(
              children: [
                PositionedDirectional(
                  top: -10.h,
                  end: -6.w,
                  child: Icon(
                    Icons.format_quote_rounded,
                    color: colorScheme.primary.withValues(alpha: 0.12),
                    size: 96.sp,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: colorScheme.primary,
                      size: 26.sp,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'home.today_motivation_quote'.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        height: 1.45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(
                          alpha: isDark ? 0.22 : 0.12,
                        ),
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        'home.today_motivation_collection'.tr(),
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
