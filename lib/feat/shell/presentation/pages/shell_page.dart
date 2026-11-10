import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goaliva/core/di/injection.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_repo.dart';

import '../../../alarm/presentation/cubit/alarm_cubit.dart';
import '../../../calendar/presentation/cubit/calendar_cubit.dart';
import '../../../calendar/presentation/pages/calendar_page.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../motivation/presentation/cubit/motivation_cubit.dart';
import '../../../motivation/presentation/pages/motivation_page.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../cubit/shell_cubit.dart';
import '../widgets/app_bottom_nav_bar.dart';

class ShellPage extends StatelessWidget {
  const ShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ShellCubit()),
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => AlarmCubit(
          alarmRepo: sl<AlarmRepo>(),
        )),
        BlocProvider(create: (_) => CalendarCubit()),
        BlocProvider(create: (_) => MotivationCubit()),
        BlocProvider(create: (_) => SettingsCubit()),
      ],
      child: const _ShellView(),
    );
  }
}

class _ShellView extends StatelessWidget {
  const _ShellView();

  static const _pages = [
    HomePage(),
    CalendarPage(),
    MotivationPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShellCubit, ShellState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(index: state.currentIndex, children: _pages),
          bottomNavigationBar: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 20.w,
              end: 20.w,
              bottom: 12.h,
            ),
            child: SafeArea(
              top: false,
              child: AppBottomNavBar(
                currentIndex: state.currentIndex,
                onTap: (index) => context.read<ShellCubit>().selectTab(index),
                items: [
                  AppBottomNavItem(
                    icon: Icons.home_rounded,
                    label: 'nav.home'.tr(),
                  ),
                  AppBottomNavItem(
                    icon: Icons.calendar_month_rounded,
                    label: 'nav.calendar'.tr(),
                  ),
                  AppBottomNavItem(
                    icon: Icons.auto_awesome_rounded,
                    label: 'nav.motivation'.tr(),
                  ),
                  AppBottomNavItem(
                    icon: Icons.settings_rounded,
                    label: 'nav.settings'.tr(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
