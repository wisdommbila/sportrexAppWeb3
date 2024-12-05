import 'package:flutter/cupertino.dart';

class AppScrollBehavior extends ScrollBehavior {
  // Use bouncing physics on all platforms, better matches the design of the app
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();
}
