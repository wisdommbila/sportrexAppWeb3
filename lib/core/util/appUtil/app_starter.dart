import 'dart:async';

import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/local_data_source.dart';
import 'package:sportRex/core/service/locale_service.dart';
import 'package:sportRex/core/util/appUtil/orientation.dart';
import 'package:sportRex/core/util/appUtil/platform_info.dart';
import 'package:sportRex/core/util/styleaUtils/app_style.dart';
import 'package:sportRex/features/onboardingScreen/view/page/onboarding_screen.dart';

class AppStater {
  Size get deviceSize {
    final w = WidgetsBinding.instance.platformDispatcher.views.first;
    return w.physicalSize / w.devicePixelRatio;
  }

  static AppStyle get style => _style;

  static AppStyle _style = AppStyle();

  Future<void> startAppEngine() async {
    debugPrint('::::: App Engine started ::::::, deviceSize >>> $deviceSize');
    _style = AppStyle(screenSize: deviceSize);

    HandleDeviceOrientation.instance.setDeviceOrientation(Axis.vertical);

    if (PlatformInfo.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }

    await loadEnvFiles();

    await locator.get<LocalStorageService>().initDb();

    await locator.get<AppLocale>().load();
    

    await Future.delayed(const Duration(seconds: 4));
adas
    String route = locator
            .get<LocalStorageService>()
            .read(dotenv.get("SCREEN_STORAGE_KEY")) ??
        OnboardingScreen.route;

    $navigate.clearAllTo(route);
  }
}
