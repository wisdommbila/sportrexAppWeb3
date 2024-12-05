import 'package:sportRex/core/commonLibs/common_libs.dart';

import 'package:sportRex/core/util/appUtil/helper.dart';

import '../../../../../core/util/app_text_field.dart';

class WithdrawFundDialog extends StatelessWidget {
  const WithdrawFundDialog({
    Key? key,
    this.onSubmit,
    this.controller,
  }) : super(key: key);

  final VoidCallback? onSubmit;
  final TextEditingController? controller;

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
        padding: horizontalPadding(size: 15),
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
                child: Text("Fund Card",
                    style: $styles.text.title2.copyWith(
                        fontWeight: FontWeight.w600,
                        color: $styles.colors.white,
                        fontSize: 18.sp)),
              ),
              Gap(40 * $styles.scale),
              AppTextField(
                title: "Enter amount",
                optionalText: "0.0003345 BTC",
                hintText: " ",
                controller: controller,
                filledColor: const Color(0XFF020E26),
              ),
              Gap(40 * $styles.scale),
              AppTextField(
                title: "Bank Name",
                hintText: " ",
                controller: controller,
                filledColor: const Color(0XFF020E26),
              ),
              Gap(40 * $styles.scale),
              AppTextField(
                title: "Account Number",
                hintText: " ",
                controller: controller,
                filledColor: const Color(0XFF020E26),
              ),
              Gap(40 * $styles.scale),
              AppBtn.from(
                onPressed: onSubmit,
                expand: true,
                bgColor: $styles.colors.secondary,
                textColor: $styles.colors.white,
                text: $strings.withdraw,
              ),
              Gap(32 * $styles.scale),
            ],
          ),
        ),
      ),
    );
  }
}
