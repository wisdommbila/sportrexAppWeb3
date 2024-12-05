import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/appUtil/app_strings.dart';

import '../../controller/controllers.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController animationController2;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    animationController2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appStarter.startAppEngine();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    animationController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    animationController2.forward();

    return Skeleton(
      bodyPadding: EdgeInsets.zero,
      backgroundColor: $styles.colors.primary,
      isBusy: false,
      body: Consumer(builder: (context, ref, watch) {
        final controller = ref.watch(splashScreenController);
        return Stack(
          children: [
            Image.asset(
              AppAssets.splashBg,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.isLogoVisible
                        ? SlideTransition(
                            position: Tween<Offset>(
                                    begin: const Offset(0, 1), end: Offset.zero)
                                .animate(animationController),
                            child: Image.asset(
                             AppAssets.sportRexGifLogo,
                              height: 170.h,width: 170.w,
                              color: $styles.colors.white,
                            ),
                          )
                        : const SizedBox.shrink(),

                    // AppImage(
                    //     fit: BoxFit.fill,
                    //     image: AssetImage(
                    //       AppAssets.sportrexLogo,
                    //     )),
                    SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(0, 1), end: Offset.zero)
                          .animate(animationController2),
                      child: Column(
                        children: [
                          controller.isTextVisible
                              ? Text(
                                  AppString.splashGamersWallet,
                                  style: $styles.text.h3
                                      .copyWith(fontWeight: FontWeight.w900),
                                )
                              : const SizedBox.shrink(),
                          controller.isTextVisible
                              ? Text(
                                  AppString.splashExclusivelyBuilt,
                                  style: $styles.text.body
                                      .copyWith(fontWeight: FontWeight.w600),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
