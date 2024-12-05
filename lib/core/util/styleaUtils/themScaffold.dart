

import 'package:flutter/material.dart';
import 'package:sportRex/core/config/dependecies.dart';
import 'package:sportRex/shared/app_scroll_behavior.dart';
class ThemeScaffold extends StatelessWidget{
   ThemeScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Theme(
          data: $styles.colors.toThemeData(),
          // Provide a default texts style to allow Hero's to render text properly
          child: DefaultTextStyle(
            style: $styles.text.body,
            // Use a custom scroll behavior across entire app
            child: ScrollConfiguration(
              behavior: AppScrollBehavior(),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
