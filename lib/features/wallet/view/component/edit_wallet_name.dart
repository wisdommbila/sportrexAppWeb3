import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/appUtil/validator.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/bottom_sheet_skeleton.dart';

class EditWalletName extends ConsumerWidget {
  const EditWalletName(
      {Key? key, required this.onSubmit, required this.walletNameController})
      : super(key: key);

  final Function(String name) onSubmit;
  final TextEditingController walletNameController;

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
          Gap(40 * $styles.scale),
          AppTextField(
            title: "Enter Wallet Name",
            hintText: "Enter wallet name",
            controller: walletNameController,
            filledColor: const Color(0XFF020E26),
          ),
          Gap(25 * $styles.scale),
          Gap(40 * $styles.scale),
          AppBtn.from(
            onPressed: () {
              if (walletNameController.text.isEmpty) {
                $toastService.showError("Enter amount");
                return;
              }
              onSubmit.call(walletNameController.text.trim());
            },
            expand: true,
            bgColor: $styles.colors.secondary,
            textColor: $styles.colors.white,
            text: "Update",
          ),
          Gap(32 * $styles.scale),
        ],
      ),
    );
  }
}
