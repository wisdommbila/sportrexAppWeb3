import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sportRex/core/config/dependecies.dart';

var defaultPadding = 20.0;

EdgeInsetsGeometry get pagePadding =>
    const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0);

EdgeInsetsGeometry horizontalPadding({double? size}) =>
    EdgeInsets.symmetric(horizontal: size ?? defaultPadding);

EdgeInsetsGeometry verticalPadding({double? size}) =>
    EdgeInsets.symmetric(vertical: size ?? defaultPadding);

double pageHeight(context) => MediaQuery.of(context).size.height;

double pageWidth(context) => MediaQuery.of(context).size.width;

SizedBox verticalSpacing({double spacing = 10}) => SizedBox(height: spacing);

SizedBox horizontalSpacing({double spacing = 10}) => SizedBox(width: spacing);

isEmpty(String? val) {
  return (val == null) || (val.trim().isEmpty);
}

isNotEmpty(String? val) {
  return !isEmpty(val);
}

isObjectEmpty(dynamic val) {
  if (val is Map) return val.isEmpty;
  if (val is List) return val.isEmpty;

  return (val == null);
}

closKeyPad(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

String concatenateBase64(String path, String encodedValue) {
  final String fileName = path.split('/').last;
  final String ext = fileName.split(".").last;
  String prefix = 'data:image/$ext;base64,';
  String base64 = prefix + encodedValue;
  return base64;
}

String getFileSizeInMB(var byeInLength) {
  double kb = byeInLength / 1024;
  return (kb / 1024).toString();
}

String getFileSizeInKb(var byeInLength) {
  double kb = byeInLength / 1024;
  return kb.toString();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

FutureOr<dynamic> decodeJson(String text) {
  if (text.codeUnits.length < 50 * 1024) {
    return jsonDecode(text);
  }
  return compute(jsonDecode, text);
}

double convertMoneyToDouble(dynamic value) =>
    double.parse((value as String).replaceAll(',', ''));



double? convertToDouble(dynamic value) {
  try {
    return double.parse((value as String).replaceAll(',', ''));
  } on FormatException catch (_) {
    return null;
  }
}

int? convertMoneyToInt(dynamic value) {
  try {
    return int.parse((value as String).replaceAll(',', ''));
  } on FormatException catch (_) {
    return null;
  }
}

String? moneyConverter(var amount) {
  amount ??= "0.00";

  if (amount == "null") {
    amount = "0.00";
  }

  return formatAmount(double.parse(amount));
}

String? formatAmount(double? amount) {
  MoneyFormatter fmf = MoneyFormatter(amount: amount ?? 0);
  return fmf.output.nonSymbol;
}

String getNameOnIndex(String? name, {int index = 0}) {
  if (name == null) {
    return "";
  }
  List nameList = name.split(" ");

  if (nameList.contains("")) {
    nameList.removeWhere((element) => element == "");
  }

  if (index > (nameList.length) - 1) {
    return "";
  }

  if (nameList.length >= index) {
    return nameList[index];
  }
  return name;
}

TextTheme getTextTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

Random _rnd = Random();

String getRandomString({int? length = 10}) =>
    String.fromCharCodes(Iterable.generate(
        length!, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String showCurrency() {
  if (Platform.isAndroid) {
    return "N";
  } else {
    return "₦";
  }
}

bool isValueInt(String? string) {
  if (isEmpty(string)) {
    return false;
  }
  return int.tryParse(string!) != null;
}

microTask(myTask) {
  Future.microtask(() {
    myTask;
  });
}

Future<Directory> getTempFile() async {
  var cacheDir = await getTemporaryDirectory();

  return cacheDir;
}

void launchUrl({required String url, Color? barColors}) async {
  try {
    await launch(
      url,
      customTabsOption: CustomTabsOption(
        toolbarColor: barColors ?? $styles.colors.primary,
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        extraCustomTabs: const <String>[
          'org.mozilla.firefox',
          'com.microsoft.emmx',
        ],
      ),
      safariVCOption: SafariViewControllerOption(
        preferredBarTintColor: barColors ?? $styles.colors.primary,
        preferredControlTintColor: Colors.white,
        barCollapsingEnabled: true,
        entersReaderIfAvailable: false,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      ),
    );
  } catch (e) {
    // An exception is thrown if browser app is not installed on Android device.
    debugPrint(e.toString());
  }
}
