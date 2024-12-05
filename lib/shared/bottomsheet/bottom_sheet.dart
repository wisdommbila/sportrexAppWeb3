import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';

class SuccessBottomsheet extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const SuccessBottomsheet({Key? key, this.title, this.subtitle})
      : super(key: key);

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
                child: Text(title ?? "Confirmation",
                    style: $styles.text.title2.copyWith(
                        fontWeight: FontWeight.w600,
                        color: $styles.colors.white,
                        fontSize: 18.sp)),
              ),
              Gap(32 * $styles.scale),
              SvgPicture.asset(AppAssets.success),
              Gap(24 * $styles.scale),
              Align(
                alignment: Alignment.center,
                child: Text(subtitle ?? "Your ETH was sent successfully",
                    maxLines: 2,
                    style: $styles.text.bodySmall.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 16.sp)),
              ),
              Gap(40 * $styles.scale),
              AppBtn.from(
                onPressed: () => $navigate.back(),
                expand: true,
                bgColor: $styles.colors.secondary,
                textColor: $styles.colors.white,
                text: "Go back",
              ),
              Gap(32 * $styles.scale),
            ],
          ),
        ),
      ),
    );
  }
}

class FailureBottomsheet extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const FailureBottomsheet({
    Key? key,
    this.title,
    this.subtitle,
  }) : super(key: key);

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
                child: Text(title ?? "Failed",
                    style: $styles.text.title2.copyWith(
                        fontWeight: FontWeight.w600,
                        color: $styles.colors.white,
                        fontSize: 18.sp)),
              ),
              Gap(32 * $styles.scale),
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: context.dy(80),
              ),
              // SvgPicture.asset(AppAssets.),
              Gap(24 * $styles.scale),
              Align(
                alignment: Alignment.center,
                child: Text(subtitle ?? "Your NFT failed to send",
                    maxLines: 2,
                    style: $styles.text.bodySmall.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 16.sp)),
              ),
              Gap(40 * $styles.scale),
              AppBtn.from(
                onPressed: () => $navigate.back(),
                expand: true,
                bgColor: $styles.colors.secondary,
                textColor: $styles.colors.white,
                text: "Go back",
              ),
              Gap(32 * $styles.scale),
            ],
          ),
        ),
      ),
    );
  }
}
