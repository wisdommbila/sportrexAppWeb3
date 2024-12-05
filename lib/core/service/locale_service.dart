import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl_standalone.dart';

import '../commonLibs/common_libs.dart';

class AppLocale {
  final Locale _defaultLocal = const Locale('en');

  AppLocalizations? _strings;

  AppLocalizations get strings => _strings!;

  bool get isLoaded => _strings != null;

  bool get isEnglish => strings.localeName == 'en';

  Future<void> load() async {
    Locale locale = _defaultLocal;
    if (kIsWeb) {
      return; // exit early on web as [findSystemLocale] throws errors as of Dec, 2022
    }
    if (kDebugMode) {
      // locale = Locale('zh'); // uncomment to test for other locale
    }

    final localeCode = await findSystemLocale();
    // Try and find a supported locale

    locale = Locale(localeCode.split('_')[0]);

    // Fall back to default
    if (AppLocalizations.supportedLocales.contains(locale) == false) {
      locale = _defaultLocal;
    }

    _strings = await AppLocalizations.delegate.load(locale);
  }

  Future<void> loadIfChanged(Locale locale) async {
    bool didChange = _strings?.localeName != locale.languageCode;
    if (didChange && AppLocalizations.supportedLocales.contains(locale)) {
      _strings = await AppLocalizations.delegate.load(locale);
    }
  }
}
