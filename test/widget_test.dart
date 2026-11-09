import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goaliva/core/theme/app_theme.dart';
import 'package:goaliva/core/theme/theme_cubit.dart';
import 'package:goaliva/feat/welcome/presentation/cubit/welcome_cubit.dart';
import 'package:goaliva/feat/welcome/presentation/pages/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
  });

  testWidgets('welcome screen shows title and records primary tap', (
    tester,
  ) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) {
            final locale = context.locale;
            return BlocProvider(
              create: (_) => ThemeCubit(prefs),
              child: MaterialApp(
                theme: AppTheme.light(locale),
                darkTheme: AppTheme.dark(locale),
                locale: locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                home: BlocProvider(
                  create: (_) => WelcomeCubit(),
                  child: const WelcomePage(),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Goaliva'), findsOneWidget);
    expect(find.text('Your Goals. Your Momentum.'), findsOneWidget);
    expect(find.text('Switch to Arabic'), findsOneWidget);

    await tester.tap(find.text('Primary'));
    await tester.pump();

    expect(find.text('Last action: Primary'), findsOneWidget);
    expect(find.text('Browse widget samples'), findsOneWidget);
  });
}
