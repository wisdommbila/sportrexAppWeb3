import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/appUtil/validator.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/bottom_sheet_skeleton.dart';

class SendToken extends ConsumerWidget {
  const SendToken(
      {Key? key,
      required this.onSubmit,
      required this.addresscontroller,
      this.title,
      required this.amountcontroller})
      : super(key: key);

  final Function(String address, String amount) onSubmit;
  final TextEditingController addresscontroller;
  final TextEditingController amountcontroller;

  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomSheetSkeleton(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Send ${title ?? ""}",
                  style: $styles.text.title2.copyWith(
                      fontWeight: FontWeight.w600,
                      color: $styles.colors.white,
                      fontSize: 18.sp)),
              AppBtn.basic(
                  semanticLabel: "semanticLabel",
                  onPressed: () async {
                    var result = await BarcodeScanner.scan();
                    if (result.type != ResultType.Barcode) {
                      $toastService.showError("Scan a valid bar code");
                    }

                    // if (!Validator.isValidEthereumAddress(result.rawContent)) {
                    //   $toastService.showError("Address not valid");
                    //   return;
                    // }

                    addresscontroller.text = result.rawContent;
                  },
                  child: const AppIcon(AppIcons.small_qrcode))
            ],
          ),

          Gap(40 * $styles.scale),
          AppTextField(
            title: "Enter Wallet Address",
            hintText: "Enter Wallet Address",
            controller: addresscontroller,
            filledColor: const Color(0XFF020E26),
          ),
          Gap(25 * $styles.scale),
          AppTextField(
            title: "Enter Amount",
            hintText: "0",
            controller: amountcontroller,
            inputFormatters: const [
              // FilteringTextInputFormatter.allow(RegExp(r'[0-9].'))
            ],
            filledColor: const Color(0XFF020E26),
          ),
          Gap(25 * $styles.scale),
          // const AppTextField(
          //   title: "Network",
          //   hintText: "BEP20",
          //   filledColor: Color(0XFF020E26),
          // ),
          Gap(40 * $styles.scale),
          AppBtn.from(
            onPressed: () {
              if (!Validator.isValidEthereumAddress(addresscontroller.text)) {
                $toastService.showError("Enter a valid address");
                return;
              }

              if (amountcontroller.text.isEmpty) {
                $toastService.showError("Enter amount");
                return;
              }
              onSubmit.call(
                  addresscontroller.text.trim(), amountcontroller.text.trim());
            },
            expand: true,
            bgColor: $styles.colors.secondary,
            textColor: $styles.colors.white,
            text: $strings.send,
          ),
          Gap(32 * $styles.scale),
        ],
      ),
    );
  }
}
