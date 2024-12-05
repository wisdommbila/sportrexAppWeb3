import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/colorUtils/color_utils.dart';

class CardFront extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;

  const CardFront({super.key, this.color, this.onPressed, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      key: const ValueKey(true),
      height: 230,
      padding: EdgeInsets.zero,
      margin: padding ?? const EdgeInsets.symmetric(horizontal: 10),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color ?? $styles.colors.black,
      ),
      child: Stack(
        children: [
          Positioned(
            left: -20,
            bottom: -30,
            child: SvgPicture.asset(AppAssets.sportRexLargeLogo,
                height: 150.h,
                width: 150.w,
                color: ColorUtils.parseHex("#4D4D4D").withOpacity(0.1)),
          ),
          Positioned(
            right: 20,
            bottom: 30,
            child: Image.asset(
              AppAssets.masterCard,
              fit: BoxFit.fill,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    AppAssets.sportrexCardName,
                    width: 110.w,
                    color: $styles.colors.white,
                    height: 15.h,
                  ),
                  Gap(5 * $styles.scale),
                  Text("OMNI",
                      textAlign: TextAlign.center,
                      style: $styles.text.title2.copyWith(
                          fontWeight: FontWeight.w300,
                          color: $styles.colors.white,
                          fontSize: 16.sp)),
                ],
              ).paddingAll(20),
              Text("Double tap to filp",
                      textAlign: TextAlign.center,
                      style: $styles.text.title2.copyWith(
                          fontWeight: FontWeight.w300,
                          color: $styles.colors.greyMedium,
                          fontSize: 12.8.sp))
                  .paddingAll(20),
            ],
          ),
        ],
      ),
    );
  }
}
