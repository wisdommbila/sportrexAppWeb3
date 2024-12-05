import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sportRex/core/config/dependecies.dart';
import 'package:sportRex/core/route/generate_route.dart';
import 'package:sportRex/features/splashScreen/view/page/splash_screen.dart';



class SportRex extends StatelessWidget {
  const SportRex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => GetMaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        title: $strings.appName,
        navigatorKey: $navigate.navigatorKey,
        initialRoute: SplashScreen.route,
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
          fontFamily: $styles.text.body.fontFamily,

        ),
      ),
    );
  }
}
