import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goaliva/core/cubit/app_cubit_cubit.dart';
import 'package:toastification/toastification.dart';

import 'core/di/injection.dart';
import 'core/routes/page_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';

class GoalivaApp extends StatelessWidget {
  const GoalivaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubitCubit(),
      child: BlocBuilder<AppCubitCubit, AppCubitState>(
        builder: (context, state) {
          return BlocProvider.value(
            value: sl<ThemeCubit>(),
            child: ScreenUtilInit(
              designSize: const Size(390, 844),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                final locale = context.locale;

                return BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, themeState) {
                    return ToastificationWrapper(
                      config: const ToastificationConfig(
                        alignment: Alignment.topCenter,
                        animationDuration: Duration(milliseconds: 300),
                        applyMediaQueryViewInsets: true,
                      ),
                      child: MaterialApp.router(
                        title: 'Goaliva',
                        debugShowCheckedModeBanner: false,
                        theme: AppTheme.light(locale),
                        darkTheme: AppTheme.dark(locale),
                        themeMode: themeState.mode,
                        locale: locale,
                        supportedLocales: context.supportedLocales,
                        localizationsDelegates: context.localizationDelegates,
                        routerConfig: PageRoutes.router,
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
