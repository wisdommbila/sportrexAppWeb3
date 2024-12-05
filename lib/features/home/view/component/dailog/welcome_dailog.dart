import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';

class WelcomeDialog extends StatelessWidget {
  const WelcomeDialog({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
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
                child: Text($strings.welcomeText,
                    style: $styles.text.title2.copyWith(
                        fontWeight: FontWeight.w600,
                        color: $styles.colors.white,
                        fontSize: 18.sp)),
              ),
              Gap(10 * $styles.scale),
              Align(
                alignment: Alignment.topLeft,
                child: Text($strings.welcomeSubText,
                    style: $styles.text.bodySmall.copyWith(
                        fontWeight: FontWeight.w400,
                        color: $styles.colors.white,
                        fontSize: 14.sp)),
              ),
              Gap(40 * $styles.scale),
              AppBtn.from(
                onPressed: onSubmit,
                expand: true,
                bgColor: $styles.colors.secondary,
                textColor: $styles.colors.white,
                text: $strings.setNow,
              ),
              Gap(30 * $styles.scale),
              AppBtn.basic(
                onPressed: () {
                  $navigate.back();
                },
                semanticLabel: "close",
                child: Text($strings.close,
                    style: $styles.text.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: $styles.colors.white,
                        fontSize: 16.sp)),
              ),
              Gap(40 * $styles.scale),
            ],
          ),
        ),
      ),
    );
  }
}
