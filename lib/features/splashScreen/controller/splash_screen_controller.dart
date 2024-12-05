import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';

class SplashScreenNotifier extends ChangeNotifier {
  
  SplashScreenNotifier(this._read) {
    decideNavigation();
  }

  // ignore: unused_field
  final Ref _read;

  bool isLogoVisible = false;
  bool isTextVisible = false;

  decideNavigation() async {
    Future.delayed(const Duration(seconds: 1), () {
      isLogoVisible = true;
      notifyListeners();
    });
    Future.delayed(const Duration(milliseconds: 3000), () {
      isTextVisible = true;
      notifyListeners();
    });

    // Future.delayed(const Duration(seconds: 6), () {
    //   $navigate.clearAllTo(OnboardingScreen.route);
    // });

    //This code delays the splash screen and pushes the next page to the screen after the delay
  }
}


final splashScreenController = ChangeNotifierProvider.autoDispose(
  (ref) => SplashScreenNotifier(ref),
);


