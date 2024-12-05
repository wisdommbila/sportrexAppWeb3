import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/token/model/data/chain_list_response.dart';
import 'package:sportRex/features/token/model/data/networks_response.dart';
import 'package:sportRex/features/token/view/component/select_network.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/bottom_sheet_skeleton.dart';
import 'package:sportRex/shared/dailog_sheet.dart';

import '../../controller/token_controller.dart';

class AddCustomToken extends ConsumerStatefulWidget {
  const AddCustomToken({
    Key? key,
    required this.onSubmit,
    required this.networksResponse,
  }) : super(key: key);

  final VoidCallback onSubmit;
  final ChainListResponse networksResponse;

  @override
  ConsumerState<AddCustomToken> createState() => _AddCustomTokenState();
}

class _AddCustomTokenState extends ConsumerState<AddCustomToken> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(tokenDetailsController.notifier);
    final update = ref.watch(tokenDetailsController);
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
            alignment: Alignment.topCenter,
            child: Text("Add Custom Token",
                style: $styles.text.title2.copyWith(
                    fontWeight: FontWeight.w400,
                    color: $styles.colors.white,
                    fontSize: 18.sp)),
          ),
          Gap(30 * $styles.scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text($strings.network,
                  style: $styles.text.title2.copyWith(
                      fontWeight: FontWeight.w400,
                      color: $styles.colors.greyMedium,
                      fontSize: 12.sp)),
              Text($strings.selectNetwork,
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
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0XFF0E1648),
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
                      Text(update.selectedNetwork!.name!,
                          style: $styles.text.title2.copyWith(
                              fontWeight: FontWeight.w400,
                              color: $styles.colors.white,
                              fontSize: 14.sp))
                    ],
                  ),
                ),
              ),
              const Gap(30),
              AppBtn.basic(
                onPressed: () {
                  showSizeSheet(
                      context,
                      SelectNetwork(
                        onSubmit: (network) {
                          controller.setSelectedNetwork(network);
                          $navigate.back();
                        },
                        networks: widget.networksResponse,
                      ));
                },
                semanticLabel: '',
                child: Container(
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
                      color: const Color(0XFF0E1648),
                    ),
                    child: Icon(
                      CupertinoIcons.forward,
                      color: Colors.white,
                      semanticLabel: $strings.changeProvider,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gap(40 * $styles.scale),
          AppTextField(
            hintText: "Contract Address",
            textAlign: TextAlign.start,
            textInputType: TextInputType.text,
            filledColor: const Color(0XFF0E1648),
            onChanged: (value) {
              controller.importToken(update.selectedNetwork!.chain!, value);
            },
            suffixWidget: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppIcon(AppIcons.small_qrcode),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Paste",
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.secondary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ))
                ],
              ),
            ),
          ),
          Gap(15 * $styles.scale),
          AppTextField(
            hintText: "Name",
            enabled: false,
            textInputType: TextInputType.number,
            controller: controller.nameController,
            inputFormatters: [MoneyFormatter()],
            filledColor: const Color(0XFF0E1648),
          ),
          Gap(15 * $styles.scale),
          AppTextField(
            hintText: "Symbol",
            enabled: false,
            controller: controller.symbolController,
            textInputType: TextInputType.number,
            inputFormatters: [MoneyFormatter()],
            filledColor: const Color(0XFF0E1648),
          ),
          Gap(15 * $styles.scale),
          AppTextField(
            hintText: "Decimal",
            enabled: false,
            controller: controller.decimalController,
            textInputType: TextInputType.number,
            inputFormatters: [MoneyFormatter()],
            filledColor: const Color(0XFF0E1648),
          ),
          Gap(32 * $styles.scale),
          AppBtn.from(
            onPressed: widget.onSubmit,
            expand: true,
            bgColor: $styles.colors.secondary,
            textColor: $styles.colors.white,
            text: "Save",
          ),
          Gap(32 * $styles.scale),
        ],
      ),
    );
  }
}
