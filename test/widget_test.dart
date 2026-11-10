import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goaliva/core/theme/app_theme.dart';
import 'package:goaliva/core/theme/theme_cubit.dart';
import 'package:goaliva/feat/shell/presentation/pages/shell_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
  });

  testWidgets('shell shows home grid and calendar tab', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

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
                home: const ShellPage(),
              ),
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
    expect(find.text('Calendar'), findsWidgets);
    expect(find.text('Motivation'), findsWidgets);
    expect(find.text('Settings'), findsWidgets);
    expect(find.textContaining('Good morning, Alex'), findsOneWidget);
    expect(find.text('Alarms'), findsOneWidget);
    expect(find.text('Events'), findsOneWidget);
    expect(find.text('Tasks'), findsOneWidget);
    expect(find.text('Goals'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text("Today's motivation"),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text("Today's motivation"), findsOneWidget);

    await tester.tap(find.text('Calendar'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Good morning, Alex'), findsNothing);
    expect(find.text('Calendar'), findsWidgets);
  });
}
