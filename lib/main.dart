import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/app.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/service/locale_service.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Logger set to debug mode
  Logger.level = Level.debug;

  //load file from .env and storage
  // await loadFiles();

  //Start app
  setUpLocator();

  //Load App Locale
  await locator.get<AppLocale>().load();


  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(
            const ProviderScope(
              child: SportRex(),
            ),
          ));

}
