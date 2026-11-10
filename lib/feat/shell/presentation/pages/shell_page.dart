import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../calendar/presentation/pages/calendar_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../motivation/presentation/pages/motivation_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../widgets/app_bottom_nav_bar.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _currentIndex = 0;

  static const _pages = [
    HomePage(),
    CalendarPage(),
    MotivationPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 20.w,
          end: 20.w,
          bottom: 12.h,
        ),
        child: SafeArea(
          top: false,
          child: AppBottomNavBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
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
  }
}
