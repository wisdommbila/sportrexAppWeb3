import 'package:flutter/material.dart';
import 'package:sportRex/core/util/colorUtils/color_utils.dart';

class AppColors {
  /// Common
  final Color primary = const Color(0xFF010E28);
  final Color primary2 = const Color(0XFF3333FF);

  final Color primary100 = const Color(0xFF142656);
  final Color primary400 = const Color(0xFF011336);
  final Color primary500 = const Color(0xFF010A1A);
  final Color primaryBorder = const Color(0xff0D2B68);

  final Color secondary = const Color(0xFF3333FF);
  final Color tertiary = Colors.white;

  final Color white = const Color(0xFFF8ECE5);
  final Color black = const Color(0xFF020202);

  final Color greyStrong = const Color(0xFF272625);
  final Color greyMedium = const Color(0xFF9D9995);
  final Color lightGrey = const Color(0xFFECEBEB);

  final Color red = const Color(0xFFFF0000);
  final Color meteorRed = const Color(0xFFAF0C0C);

  final Color orange = const Color(0xFFFFB707);
  final Color green = const Color(0xFF09CE35);
  final Color asteriodBlue = const Color(0xFF192468);

  final Color transparent = Colors.transparent;

  final Color offWhite = const Color(0xFFF8ECE5);

  final bool isDark = true;

  Color shift(Color c, double d) =>
      ColorUtils.shiftHsl(c, d * (isDark ? -1 : 1));

  ThemeData toThemeData() {
    /// Create a TextTheme and ColorScheme, that we can use to generate ThemeData
    TextTheme txtTheme =
        (isDark ? ThemeData.dark() : ThemeData.light()).textTheme;

    ColorScheme colorScheme = ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: primary,
        primaryContainer: primary,
        onPrimary: black,
        onPrimaryContainer: black,
        secondary: secondary,
        secondaryContainer: secondary,
        onSecondaryContainer: white,
        onSecondary: white,
        tertiary: tertiary,
        tertiaryContainer: tertiary,
        onTertiary: white,
        onTertiaryContainer: white,
        background: primary,
        onBackground: black,
        onError: white,
        errorContainer: Colors.red.shade200,
        onErrorContainer: white,
        error: Colors.red.shade400,
        surface: primary,
        onSurface: black);

    /// Now that we have ColorScheme and TextTheme, we can create the ThemeData
    /// Also add on some extra properties that ColorScheme seems to miss
    var theme =
        ThemeData.from(textTheme: txtTheme, colorScheme: colorScheme).copyWith(
      textSelectionTheme: TextSelectionThemeData(cursorColor: white),
      
      unselectedWidgetColor: Colors.grey,
      highlightColor: primary,
    );

    /// Return the themeData which MaterialApp can now use
    return theme;
  }
}
