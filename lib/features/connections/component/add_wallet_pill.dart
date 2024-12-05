import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/shared/app_icons.dart';

import '../../../core/commonLibs/common_libs.dart';
import '../../../shared/app_image.dart';

// ignore: must_be_immutable
class AddWalletPill extends StatelessWidget {
  AddWalletPill(
      {Key? key,
      required this.title,
      this.subTitle,
      this.isPrimary = false,
      required this.onPressed,
      required this.img})
      : super(key: key);

  String title;
  String? subTitle;
  AppIcons img;
  bool? isPrimary;
  Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 64,
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
      decoration: BoxDecoration(
        color: $styles.colors.primary,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: $styles.colors.primaryBorder, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                // color: $styles.colors.tertiary,
                borderRadius: BorderRadius.circular(10)),
            child: AppIcon(
              img,
              isSvg: false,
              size: context.dx(34),
            ).paddingAll(4),
          ),

          Gap(20 * $styles.scale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: $styles.text.body.copyWith(
                    color: $styles.colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
              if (subTitle != null) ...[
                SizedBox(
                  width: context.dx(254),
                  child: Text(
                    subTitle!,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.greyMedium,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ]
            ],
          ),

          // IconButton(
          //
          //   onPressed: onPressed,
          // )
        ],
      ).paddingOnly(left: 10),
    );
  }
}

// ignore: must_be_immutable
class AddWalletListPill extends StatelessWidget {
  AddWalletListPill(
      {Key? key,
      required this.title,
      this.subTitle,
      required this.onPressed,
      this.img,
      this.acctionText})
      : super(key: key);

  String title;
  String? subTitle;
  String? acctionText;
  dynamic img;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
      constraints: BoxConstraints(minHeight: context.dy(64)),
      decoration: BoxDecoration(
        color: $styles.colors.primary400,
        border: Border.symmetric(
            horizontal:
                BorderSide(color: $styles.colors.primaryBorder, width: 0.5)),
      ),
      child: Row(
        children: [
          img != null
              ? Container(
                  width: context.dy(40),
                  height: context.dy(40),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white),
                  child: AppImage(
                    image: AssetImage(img),
                    width: context.dx(32),
                    height: context.dx(32),
                  ),
                )
              : const SizedBox.shrink(),
          Gap(20 * $styles.scale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: $styles.text.body.copyWith(
                    color: $styles.colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
              subTitle == null
                  ? const SizedBox.shrink()
                  : SizedBox(
                      width: context.dx(200),
                      child: Text(
                        subTitle!,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.greyMedium,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
            ],
          ),
          const Spacer(),
          acctionText == null
              ? IconButton(
                  onPressed: onPressed,
                  icon: SvgPicture.asset(
                    AppAssets.disconnect,
                    color: $styles.colors.greyMedium,
                    width: context.dx(24),
                    height: context.dx(24),
                  ),
                )
              : Text(
                  acctionText!,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: $styles.text.body.copyWith(
                      color: $styles.colors.greyMedium,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
        ],
      ).paddingOnly(left: 10),
    );
  }
}
