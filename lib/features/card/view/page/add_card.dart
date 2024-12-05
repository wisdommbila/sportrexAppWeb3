import 'package:carousel_slider/carousel_slider.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/card/view/component/card/debit_card.dart';
import 'package:sportRex/features/card/view/component/card_indicator.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/base_background.dart';

class AddCard extends StatelessWidget {
  static const route = '/AddCard';
  AddCard({super.key});

  // TODO: Please move to ui state
  final List<Color> cardType = [
    $styles.colors.black,
    $styles.colors.greyMedium,
    $styles.colors.secondary,
    $styles.colors.green,
    $styles.colors.meteorRed,
  ];

  final buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        isAuthSkeleton: false,
        bodyPadding: EdgeInsets.zero,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: $strings.addCard,
          textColor: $styles.colors.white,
          actions: [
            Icon(
              Icons.remove_red_eye,
              color: $styles.colors.white,
              size: 24,
            ).paddingOnly(right: 10)
          ],
        ),
        backgroundColor: $styles.colors.primary,
        body: BaseImageBackground(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CarouselSlider(
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                        height: 260.h,

                        viewportFraction: 0.95,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: false,

                        onPageChanged: (index, reason) {},
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,

                        enlargeFactor: 0.3,
                        // onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: cardType.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return FlipDebitCard(
                              color: i,
                            );
                          },
                        );
                      }).toList(),
                    ),
                    const Gap(20),
                    CardColorList(
                      activeIndex: 0,
                      list: cardType,
                      onPressed: (index) {
                        buttonCarouselController.animateToPage(index);
                      },
                    ),
                    const Gap(20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          title: $strings.cardHolderName,
                          hintText: $strings.enterName,
                        ),
                        const Gap(15),
                        Text($strings.networkProvider,
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.greyMedium,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400)),
                        Gap(20 * $styles.scale),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: $styles.colors.transparent,
                            border:
                                Border.all(color: $styles.colors.primary100),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const CustomDropDownWithImage(
                            list: [
                              (
                                name: "Master",
                                icon: AppIcons.mastercard,
                                isSvg: false
                              ),
                              (
                                name: "Visa",
                                icon: AppIcons.mastercard,
                                isSvg: false
                              ),
                            ],
                          ),
                        ),
                        const Gap(15),
                        Text($strings.selectCoin,
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.greyMedium,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400)),
                        Gap(20 * $styles.scale),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: $styles.colors.transparent,
                            border:
                                Border.all(color: $styles.colors.primary100),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: CustomDropDownWithImage(
                            list: [
                              (
                                name: $strings.bitcoin,
                                icon: AppIcons.btc,
                                isSvg: false
                              ),
                              (
                                name: $strings.bitcoin,
                                icon: AppIcons.btc,
                                isSvg: false
                              ),
                              (
                                name: $strings.bitcoin,
                                icon: AppIcons.btc,
                                isSvg: false
                              ),
                            ],
                          ),
                        ),
                        Gap(40 * $styles.scale),
                        Align(
                          alignment: Alignment.center,
                          child: Text($strings.creationFee(10),
                              style: $styles.text.body.copyWith(
                                  color: $styles.colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400)),
                        ),
                        Gap(20 * $styles.scale),
                        AppBtn.from(
                          bgColor: $styles.colors.secondary,
                          expand: true,
                          onPressed: () {},
                          textColor: $styles.colors.white,
                          text: $strings.createCard,
                        ),
                        const Gap(50),
                      ],
                    ).paddingSymmetric(horizontal: 16)
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class CustomDropDownWithImage extends StatelessWidget {
  final List<({String name, AppIcons icon, bool isSvg})> list;

  const CustomDropDownWithImage({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(7),
          dropdownColor: $styles.colors.asteriodBlue,
          selectedItemBuilder: (context) {
            return list.map((option) {
              return DropdownMenuItem<String>(
                value: option.name,
                child: Row(
                  children: [
                    AppIcon(
                      option.icon,
                      isSvg: option.isSvg,
                    ),
                    const Gap(5),
                    Text(option.name,
                        textAlign: TextAlign.center,
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              );
            }).toList();
          },
          style: $styles.text.body.copyWith(
              color: $styles.colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400),
          items: list.map((option) {
            return DropdownMenuItem<String>(
              value: option.name,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(5),
                  Row(
                    children: [
                      AppIcon(
                        option.icon,
                        isSvg: option.isSvg,
                      ),
                      const Gap(5),
                      Text(option.name,
                          textAlign: TextAlign.center,
                          style: $styles.text.body.copyWith(
                              color: $styles.colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  Divider(
                    color: $styles.colors.greyMedium.withOpacity(0.2),
                    thickness: 1,
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {}),
    );
  }
}
