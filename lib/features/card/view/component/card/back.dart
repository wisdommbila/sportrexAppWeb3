import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/shared/line.dart';

class BackCard extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;

  const BackCard({super.key, this.color, this.onPressed, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey(false),
      width: 1.sw,
      height: 230,
      padding: EdgeInsets.zero,
      margin: padding ?? const EdgeInsets.symmetric(horizontal: 10),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color ?? $styles.colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(20 * $styles.scale),
          SizedBox(
              width: double.infinity,
              height: 35,
              child: ColoredBox(
                color: $styles.colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Double tap to flip",
                            textAlign: TextAlign.center,
                            style: $styles.text.title2.copyWith(
                                fontWeight: FontWeight.w300,
                                color: $styles.colors.black,
                                fontSize: 12.sp))
                        .paddingOnly(right: 10),
                  ],
                ),
              )),
          const Gap(10),
          SizedBox(
            width: 0.65.sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppAssets.sportRexLargeLogo,
                  color: $styles.colors.white.withOpacity(0.8),
                  width: 30,
                  height: 30,
                ),
                const Gap(
                  10,
                ),
                HorizontalLine(
                  thickness: 1,
                  color: $styles.colors.white,
                ),
                const Gap(5),
                Text("CARDHOLDER NAME:",
                    textAlign: TextAlign.center,
                    style: $styles.text.title2.copyWith(
                        fontWeight: FontWeight.w300,
                        color: $styles.colors.white,
                        fontSize: 12.sp)),
                Text("SATOSHI NAKAMOTO",
                    textAlign: TextAlign.center,
                    style: $styles.text.title2.copyWith(
                        fontWeight: FontWeight.w600,
                        color: $styles.colors.white,
                        fontSize: 18.sp)),
                const Gap(5),
                HorizontalLine(
                  thickness: 1,
                  color: $styles.colors.white,
                ),
                const Gap(5),
                Text("CARD NUMBER:",
                    textAlign: TextAlign.center,
                    style: $styles.text.title2.copyWith(
                        fontWeight: FontWeight.w300,
                        color: $styles.colors.white,
                        fontSize: 12.sp)),
                const Gap(2),
                Text("4319 8890 0984 4645",
                    textAlign: TextAlign.center,
                    style: $styles.text.title2.copyWith(
                        fontWeight: FontWeight.w500,
                        color: $styles.colors.white,
                        fontSize: 18.sp)),
                const Gap(5),
                HorizontalLine(
                  thickness: 1,
                  color: $styles.colors.white,
                ),
              ],
            ).paddingOnly(left: 20),
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("CVC  879",
                  textAlign: TextAlign.center,
                  style: $styles.text.title2.copyWith(
                      fontWeight: FontWeight.w300,
                      color: $styles.colors.white,
                      fontSize: 12.sp)),
              Text("EXP  09/21",
                  textAlign: TextAlign.center,
                  style: $styles.text.title2.copyWith(
                      fontWeight: FontWeight.w300,
                      color: $styles.colors.white,
                      fontSize: 12.sp)),
              Text("www.sportrex.io",
                  textAlign: TextAlign.center,
                  style: $styles.text.title2.copyWith(
                      fontWeight: FontWeight.w300,
                      color: $styles.colors.white,
                      fontSize: 12.sp)),
            ],
          ).paddingSymmetric(horizontal: 20)
        ],
      ),
    );
  }
}
