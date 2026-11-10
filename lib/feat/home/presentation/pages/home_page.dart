import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_week_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late Set<DateTime> _completedDays;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _focusedDay = now;
    _selectedDay = now;
    _completedDays = _mockCompletedDays(now);
  }

  /// Marks Mon–Thu of the focused week as completed (design mock).
  Set<DateTime> _mockCompletedDays(DateTime around) {
    final monday = around.subtract(Duration(days: around.weekday - 1));
    return {
      for (var i = 0; i < 4; i++)
        DateTime(monday.year, monday.month, monday.day + i),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsetsDirectional.fromSTEB(20.w, 12.h, 20.w, 28.h),
          children: [
            const _HomeTopBar(),
            SizedBox(height: 24.h),
            _WelcomeHeader(isArabic: isArabic),
            SizedBox(height: 20.h),
            AppWeekCalendar(
              title: 'home.momentum_title'.tr(),
              statusText: 'home.momentum_status'.tr(),
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              completedDays: _completedDays,
              onDaySelected: (selected, focused) {
                setState(() {
                  _selectedDay = selected;
                  _focusedDay = focused;
                });
              },
              onPageChanged: (focused) {
                setState(() {
                  _focusedDay = focused;
                  _completedDays = _mockCompletedDays(focused);
                });
              },
            ),
            SizedBox(height: 20.h),
            _QuickGrid(isDark: isDark),
            SizedBox(height: 20.h),
            _TodayMotivationCard(isDark: isDark),
          ],
        ),
      ),
    );
  }
}

class _HomeTopBar extends StatelessWidget {
  const _HomeTopBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final success = isDark ? AppColors.darkSuccess : AppColors.lightSuccess;

    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: isDark ? 0.22 : 0.12),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.gps_fixed_rounded,
            color: colorScheme.primary,
            size: 22.sp,
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
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'home.brand_subtitle'.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              Icons.notifications_none_rounded,
              size: 26.sp,
              color: colorScheme.onSurfaceVariant,
            ),
            PositionedDirectional(
              top: 0,
              end: 1,
              child: Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: success,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.scaffoldBackgroundColor,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 12.w),
        CircleAvatar(
          radius: 18.r,
          backgroundColor:
              colorScheme.primary.withValues(alpha: isDark ? 0.28 : 0.16),
          child: Text(
            'A',
            style: theme.textTheme.titleSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final success = isDark ? AppColors.darkSuccess : AppColors.lightSuccess;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'home.greeting'.tr()),
                    TextSpan(text: ' ${'home.greeting_wave'.tr()}'),
                  ],
                ),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: isArabic ? 0 : -0.3,
                  height: 1.2,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurfaceElevated
                    : AppColors.lightSurfaceRecessed,
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(
                  color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🔥', style: TextStyle(fontSize: 12.sp)),
                  SizedBox(width: 4.w),
                  Text(
                    'home.streak'.tr(),
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'home.motto'.tr(),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _QuickGrid extends StatelessWidget {
  const _QuickGrid({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final success = isDark ? AppColors.darkSuccess : AppColors.lightSuccess;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    final tiles = [
      (
        Icons.alarm_rounded,
        'home.grid_alarms'.tr(),
        'home.grid_alarms_count'.tr(),
        secondary,
      ),
      (
        Icons.event_rounded,
        'home.grid_events'.tr(),
        'home.grid_events_count'.tr(),
        colorScheme.primary,
      ),
      (
        Icons.checklist_rounded,
        'home.grid_tasks'.tr(),
        'home.grid_tasks_count'.tr(),
        success,
      ),
      (
        Icons.flag_rounded,
        'home.grid_goals'.tr(),
        'home.grid_goals_count'.tr(),
        colorScheme.primary,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 1.35,
      ),
      itemBuilder: (context, index) {
        final tile = tiles[index];
        return _QuickGridTile(
          icon: tile.$1,
          title: tile.$2,
          subtitle: tile.$3,
          accent: tile.$4,
          isDark: isDark,
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
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: isDark ? 0.2 : 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: accent, size: 20.sp),
          ),
          const Spacer(),
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
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
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.format_quote_rounded,
                color: colorScheme.primary,
                size: 28.sp,
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
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: colorScheme.primary
                      .withValues(alpha: isDark ? 0.18 : 0.1),
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
        ),
      ],
    );
  }
}
