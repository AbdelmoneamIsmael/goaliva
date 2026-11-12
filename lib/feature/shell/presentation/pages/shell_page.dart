import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goaliva/feature/shell/presentation/cubit/shell_cubit.dart';
import 'package:goaliva/feature/shell/presentation/widgets/app_bottom_nav_bar.dart';

class ShellPage extends StatelessWidget {
  const ShellPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShellCubit, ShellState>(
      builder: (context, state) {
        return Scaffold(
          body: child,
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
                onTap: (index) =>
                    context.read<ShellCubit>().selectTab(context, index),
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
