import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/dex/controller/swap_controller.dart';
import 'package:sportRex/features/dex/model/enum.dart';
import 'package:sportRex/features/dex/model/swap_coin.dart';
import 'package:sportRex/features/dex/model/token_swap.dart';
import 'package:sportRex/features/dex/view/page/swap.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/app_image.dart';

class SwapBoxWidget extends ConsumerWidget {
  final SwapData? data;
  final TextEditingController controller;

  const SwapBoxWidget(
      {super.key, required this.data, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: $styles.colors.primary100, width: 0.5),
          gradient: LinearGradient(colors: [
            $styles.colors.primary400,
            $styles.colors.black.withOpacity(0.2),
          ], stops: const [
            0.0,
            0.9
          ])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data?.swapType?.metaData.message ?? '',
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.greyMedium,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                Gap(10 * $styles.scale),
                MoneyTextField(
                  readOnly: data?.swapType == SwapType.swapDestination,
                  onChanged: (amount) {
                    ref.read(swapController.notifier).onPriceChange(
                        amount: amount, swapType: data!.swapType!);
                  },
                  controller: controller,
                ),
                Gap(10 * $styles.scale),
                Text("Balance :0 ${data?.swapTokens?.symbol ?? ''}",
                    maxLines: 1,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.greyMedium,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppBtn(
                onPressed: () async {
                  final result =
                      await $navigate.to(ItemSwapPage.route) as SwapTokens?;
                  if (isObjectEmpty(result)) return;
                  ref
                      .read(swapController.notifier)
                      .updateSwapToken(result!, data!.swapType!);
                },
                semanticLabel: "",
                bgColor: $styles.colors.transparent,
                child: Row(
                  children: [
                    AppImage(
                      color: $styles.colors.transparent,
                      height: 40,
                      width: 40,
                      image: NetworkImage(data?.swapTokens?.logoUri ?? ''),
                    ),
                    Gap(20 * $styles.scale),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 100),
                      child: Text(
                        data?.swapTokens?.symbol ?? 'Select Token',
                        maxLines: 1,
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Gap(5 * $styles.scale),
                    const AppIcon(AppIcons.forward)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
