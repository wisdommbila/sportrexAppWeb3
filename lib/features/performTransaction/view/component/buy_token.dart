import 'package:flutter/cupertino.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/performTransaction/view/component/select_provider.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/bottom_sheet_skeleton.dart';
import 'package:sportRex/shared/dailog_sheet.dart';

class BuyToken extends StatelessWidget {
  const BuyToken(
      {Key? key,
      required this.onSubmit,
      this.title,
      required this.amountcontroller})
      : super(key: key);

  final Function(String amount) onSubmit;

  final TextEditingController amountcontroller;

  final String? title;

  @override
  Widget build(BuildContext context) {
    return BottomSheetSkeleton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(20 * $styles.scale),
          Container(
            width: 80.w,
            height: 5.h,
            decoration: BoxDecoration(
                color: $styles.colors.primary.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10)),
          ),
          Gap(20 * $styles.scale),
          Align(
            alignment: Alignment.topLeft,
            child: Text("Buy Eth",
                style: $styles.text.title2.copyWith(
                    fontWeight: FontWeight.w600,
                    color: $styles.colors.white,
                    fontSize: 18.sp)),
          ),
          Gap(30 * $styles.scale),
          AppTextField(
            title: "Enter Amount in \$",
            maxLines: 1,
            prefixWidget: SizedBox(
              height: 50.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("\$",
                      style: $styles.text.title2.copyWith(
                          fontWeight: FontWeight.w600,
                          color: $styles.colors.white,
                          fontSize: 18.sp)),
                ],
              ),
            ),
            hintText: "0\$",
            controller: amountcontroller,
            textInputType: TextInputType.number,
            inputFormatters: [MoneyFormatter()],
            filledColor: const Color(0XFF020E26),
          ),
          // Gap(15 * $styles.scale),
          // Text("0.0 Eth",
          //     style: $styles.text.title2.copyWith(
          //         fontWeight: FontWeight.w600,
          //         color: $styles.colors.white,
          //         fontSize: 18.sp)),
          Gap(35 * $styles.scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text($strings.activeProvider,
                  style: $styles.text.title2.copyWith(
                      fontWeight: FontWeight.w400,
                      color: $styles.colors.greyMedium,
                      fontSize: 12.sp)),
              Text($strings.changeProvider,
                  style: $styles.text.title2.copyWith(
                      fontWeight: FontWeight.w400,
                      color: $styles.colors.greyMedium,
                      fontSize: 12.sp)),
            ],
          ),
          Gap(10 * $styles.scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        $styles.colors.primary400,
                        $styles.colors.secondary,
                      ], stops: const [
                        0.0,
                        2.5
                      ]),
                      border: Border.all(
                          color: $styles.colors.secondary, width: 0.5)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppIcon(
                        AppIcons.binance,
                        size: 24,
                      ),
                      const Gap(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Transak",
                              style: $styles.text.title2.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: $styles.colors.white,
                                  fontSize: 14.sp)),
                          const Gap(6),
                          Text($strings.thirdPartyProvider,
                              style: $styles.text.title2.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: $styles.colors.greyMedium,
                                  fontSize: 12.sp))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(30),
              AppBtn.basic(
                onPressed: () {
                  showSizeSheet(context, SelectProvider(onSubmit: () {
                    $navigate.back();
                  }));
                },
                semanticLabel: '',
                child: const SelectorGradientBackground(),
              ),
            ],
          ),
          Gap(40 * $styles.scale),
          AppBtn.from(
            onPressed: () {
              if (amountcontroller.text.isEmpty) {
                $toastService.showError("Enter amount");
                return;
              }
              onSubmit.call(amountcontroller.text.trim());
            },
            expand: true,
            bgColor: $styles.colors.secondary,
            textColor: $styles.colors.white,
            text: $strings.buy,
          ),
          Gap(32 * $styles.scale),
        ],
      ),
    );
  }
}

class SelectorGradientBackground extends StatelessWidget {
  const SelectorGradientBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFAC744),
            Color(0xFF8B14EF),
            Color(0xFF3333FF),
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            $styles.colors.primary400,
            $styles.colors.secondary,
          ], stops: const [
            0.0,
            4
          ]),
        ),
        child: Icon(
          CupertinoIcons.forward,
          color: Colors.white,
          semanticLabel: $strings.changeProvider,
        ),
      ),
    );
  }
}
