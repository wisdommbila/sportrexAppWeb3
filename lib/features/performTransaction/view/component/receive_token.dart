import 'package:qr_flutter/qr_flutter.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/bottom_sheet_skeleton.dart';

class ReceiveToken extends StatelessWidget {
  const ReceiveToken(
      {Key? key, required this.onSubmit, this.title, this.address})
      : super(key: key);
  final String? title;

  final String? address;
  final Function(String address) onSubmit;

  @override
  Widget build(BuildContext context) {
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
              Text(title ?? "Receive Bitcoin",
                  style: $styles.text.title2.copyWith(
                      fontWeight: FontWeight.w600,
                      color: $styles.colors.white,
                      fontSize: 18.sp)),
              const AppIcon(AppIcons.share)
            ],
          ),
          Gap(40 * $styles.scale),
          Center(
            child: Container(
              width: 220,
              height: 220,
              padding: EdgeInsets.all(2.w),
              child: Stack(
                children: [
                  SvgPicture.asset(
                    AppAssets.qrCodeBackground,
                    width: 240,
                    height: 240,
                  ),
                  Center(
                    child: QrImageView(
                      data: address ?? '',
                      version: QrVersions.max,
                      padding: EdgeInsets.zero,
                      embeddedImage: AssetImage(AppAssets.appQrCode),
                      backgroundColor: $styles.colors.white,
                      embeddedImageStyle:
                          const QrEmbeddedImageStyle(size: Size(40, 40)),
                      eyeStyle: const QrEyeStyle(
                          eyeShape: QrEyeShape.square, color: Colors.black),
                      gapless: true,
                    ),
                  ).paddingAll(15),
                ],
              ),
            ),
          ),
          Gap(40 * $styles.scale),
          Text("Wallet Address ",
              style: $styles.text.title2.copyWith(
                  fontWeight: FontWeight.w400,
                  color: $styles.colors.white,
                  fontSize: 14.sp)),
          Gap(15 * $styles.scale),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: $styles.colors.primary),
            child: Text("$address",
                textAlign: TextAlign.center,
                style: $styles.text.title2.copyWith(
                    fontWeight: FontWeight.w400,
                    color: $styles.colors.white,
                    fontSize: 12.sp)),
          ),
          Gap(40 * $styles.scale),
          AppBtn.from(
            onPressed: () {
              onSubmit.call(address ?? '');
            },
            expand: true,
            bgColor: $styles.colors.secondary,
            textColor: $styles.colors.white,
            text: $strings.copy,
          ),
          Gap(32 * $styles.scale),
        ],
      ),
    );
  }
}
