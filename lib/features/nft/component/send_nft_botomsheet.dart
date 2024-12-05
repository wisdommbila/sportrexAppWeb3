import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/config/constant.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/performTransaction/controller/perform_transaction_controller.dart';
import 'package:sportRex/shared/app_image.dart';
import 'package:sportRex/shared/bottomsheet/bottom_sheet.dart';
import 'package:sportRex/shared/dailog_sheet.dart';

import '../../../core/util/appUtil/validator.dart';

class SendNFTBottomsheet extends ConsumerWidget {
  const SendNFTBottomsheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController();
    return Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF002B81),
              Color(0xFF011846),
            ],
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.02),
                spreadRadius: pageHeight(context),
                blurRadius: 1)
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
      child: Padding(
        padding: horizontalPadding(size: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                child: Text("Send NFT",
                    style: $styles.text.title2.copyWith(
                        fontWeight: FontWeight.w600,
                        color: $styles.colors.white,
                        fontSize: 18.sp)),
              ),
              Gap(10 * $styles.scale),
              Align(
                alignment: Alignment.topLeft,
                child: Text(dummyText,
                    maxLines: 2,
                    style: $styles.text.bodySmall.copyWith(
                        fontWeight: FontWeight.w400,
                        color: $styles.colors.greyMedium,
                        fontSize: 14.sp)),
              ),
              Gap(40 * $styles.scale),
              AppTextField(
                title: "Enter Address",
                hintText: "Type somthing",
                controller: controller,
                filledColor: const Color(0XFF020E26),
              ),
              Gap(40 * $styles.scale),
              AppBtn.from(
                onPressed: () {
                  if (!Validator.isValidEthereumAddress(controller.text)) {
                    $toastService.showError("Enter a valid address");
                    return;
                  }

                  // _sendNft("0xFFf0e7976881f64d98176075e47729DB4E96B92F", ref,
                  //     context);

                  _sendNft(controller.text.trim(), ref, context);
                },
                expand: true,
                bgColor: $styles.colors.secondary,
                textColor: $styles.colors.white,
                text: $strings.send,
              ),
              Gap(32 * $styles.scale),
            ],
          ),
        ),
      ),
    );
  }

  _sendNft(String address, WidgetRef ref, BuildContext context) async {
    final proceed =
        await ref.read(performTransactionController.notifier).sendNFT(address);

    if (proceed) {
      $navigate.popUntil(2);
      // if (mounted) {
      showSizeSheet(
          context,
          const SuccessBottomsheet(
            subtitle: "Your NFT was sent successfully",
          ));
      // }
    } else {
      $navigate.popUntil(2);

      showSizeSheet(
          context,
          const FailureBottomsheet(
            subtitle: "Unable to complete Transaction",
          ));
    }
  }
}

class RecieveNFTBottomsheet extends StatelessWidget {
  const RecieveNFTBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF002B81),
              Color(0xFF011846),
            ],
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.02),
                spreadRadius: pageHeight(context),
                blurRadius: 1)
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
      child: Padding(
        padding: horizontalPadding(size: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recieve NFT",
                        style: $styles.text.title2.copyWith(
                            fontWeight: FontWeight.w600,
                            color: $styles.colors.white,
                            fontSize: 18.sp)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share))
                  ],
                ),
              ),
              Gap(40 * $styles.scale),
              AppImage(image: AssetImage(AppAssets.qrCode)),
              Gap(40 * $styles.scale),
              Text("Wallet Address",
                  textAlign: TextAlign.center,
                  style: $styles.text.title2.copyWith(
                      fontWeight: FontWeight.w400,
                      color: $styles.colors.white,
                      fontSize: 14.sp)),
              Gap(8 * $styles.scale),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: const Color(0xff020733)),
                child: Text("bgececwvhdfhfyr736ur348jshggdgfhdhgh1ag",
                    textAlign: TextAlign.center,
                    style: $styles.text.title2.copyWith(
                        fontWeight: FontWeight.w400,
                        color: $styles.colors.white,
                        fontSize: 14.sp)),
              ),
              Gap(40 * $styles.scale),
              AppBtn.from(
                onPressed: () {},
                expand: true,
                bgColor: $styles.colors.secondary,
                textColor: $styles.colors.white,
                text: $strings.copy,
              ),
              Gap(32 * $styles.scale),
            ],
          ).paddingSymmetric(horizontal: 16),
        ),
      ),
    );
  }
}
