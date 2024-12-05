// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/local_data_source.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/core/util/appUtil/app_strings.dart';
import 'package:sportRex/features/onboardingScreen/view/page/create_wallet_screen.dart';
import 'package:sportRex/shared/base_background.dart';

import '../../../../shared/app_icons.dart';
import '../component/component.dart';

class OnboardingScreen extends StatefulWidget {
  static const route = '/onboardingScreen';

  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingPage> slides = <OnboardingPage>[
    OnboardingPage(
        image: AppAssets.onboarding1,
        title: AppString.onboardingTitle1,
        desc: AppString.onboardingText1),
    OnboardingPage(
        image: AppAssets.onboarding2,
        title: AppString.onboardingTitle2,
        desc: AppString.onboardingText2),
    OnboardingPage(
        image: AppAssets.onboarding3,
        title: AppString.onboardingTitle3,
        desc: AppString.onboardingText3),
  ];
  int currentIndex = 0;
  late PageController _controller;
  late Timer? _pageAnimationTimer;

  void _animateSlides() {
    if (_controller == null) return;
    if (currentIndex < 4) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void initState() {
    _pageAnimationTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _animateSlides();
    });
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageAnimationTimer?.cancel();
    _pageAnimationTimer = null;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      // appBar: AppBar(elevation: 0),
      isBusy: false,
      bodyPadding: EdgeInsets.zero,
      body: BaseImageBackground(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: $styles.scale.reactive(30)!),
              child: AppIcon(
                AppIcons.logotext,
                size: context.dy(135.43),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: PageView(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  children: slides,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                ),
              ),
              $styles.scale.verticalSpace
                  .marginOnly(top: $styles.scale.reactive(32)!),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [buildIndicators()],
              ),
              context.vSpace(48),
              currentIndex == 2
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: $styles.insets.md),
                      child: AppBtn.from(
                        onPressed: () {
                          locator.get<LocalStorageService>().create(
                              dotenv.get("SCREEN_STORAGE_KEY"),
                              CreateWalletScreen.route);
                          $navigate.to(CreateWalletScreen.route);
                        },
                        text: AppString.create0rImportWallet,
                        bgColor: $styles.colors.primary2,
                        expand: true,
                      ),
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: $styles.insets.md),
                      child: AppBtn.from(
                        onPressed: () {
                          setState(() {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          });
                        },
                        text: AppString.next,
                        isSecondary: true,
                        bgColor: $styles.colors.primary2,
                        expand: true,
                      ),
                    ),
              context.vSpace(18),
              currentIndex == 2
                  ? $styles.scale.verticalSpace.marginAll(16)
                  : TextButton(
                      onPressed: () {
                        locator.get<LocalStorageService>().create(
                            dotenv.get("SCREEN_STORAGE_KEY"),
                            CreateWalletScreen.route);
                        $navigate.to(CreateWalletScreen.route);
                      },
                      child: Text(
                        AppString.skip,
                        style: $styles.text.btn.copyWith(
                            color: $styles.colors.white,
                            fontWeight: FontWeight.w600),
                      )),
              context.vSpace(60),
            ],
          ),
        ],
      ),
    );
  }

  Row buildIndicators() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: $styles.scale.reactive(4),
          width: currentIndex == 0
              ? $styles.scale.reactive(24)
              : $styles.scale.reactive(17),
          color: currentIndex == 0
              ? $styles.colors.primary2
              : const Color(0xFFD9D9D9),
        ),
        const SizedBox(width: 8),
        Container(
          height: $styles.scale.reactive(4),
          width: currentIndex == 1
              ? $styles.scale.reactive(24)
              : $styles.scale.reactive(17),
          color: currentIndex == 1
              ? $styles.colors.primary2
              : const Color(0xFFD9D9D9),
        ),
        const SizedBox(width: 8),
        Container(
          height: $styles.scale.reactive(4),
          width: currentIndex == 2
              ? $styles.scale.reactive(24)
              : $styles.scale.reactive(17),
          color: currentIndex >= 2
              ? $styles.colors.primary2
              : const Color(0xFFD9D9D9),
        ),
      ],
    );
  }
}
