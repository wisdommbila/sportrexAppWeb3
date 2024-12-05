import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/colorUtils/color_utils.dart';
import 'package:sportRex/shared/app_icons.dart';

class DebitCard extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;

  const DebitCard({super.key, this.color, this.onPressed, this.padding});

  @override
  Widget build(BuildContext context) {
    return AppBtn.basic(
      onPressed: () {
        onPressed?.call();
      },
      pressEffect: false,
      semanticLabel: $strings.debitCard,
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.zero,
        margin: padding ?? const EdgeInsets.symmetric(horizontal: 10),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color ?? ColorUtils.parseHex('#3333FF')),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              child: Image.asset(
                AppAssets.world,
                filterQuality: FilterQuality.high,
                color: $styles.colors.white.withOpacity(0.8),
                fit: BoxFit.fill,
              ).paddingOnly(left: 30),
            ),
            Positioned(
              right: 0,
              bottom: 20,
              child: SvgPicture.asset(AppAssets.sportRexLargeLogo,
                      height: 150.h,
                      width: 150.w,
                      color: ColorUtils.parseHex("#4D4D4D").withOpacity(0.1))
                  .paddingOnly(
                right: 10,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text($strings.premium,
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700)),
                    const AppIcon(
                      AppIcons.btc,
                      isSvg: false,
                      size: 34,
                    )
                  ],
                ),
                const Gap(50),
                Row(
                  children: [
                    Text("\$ 50,000,000",
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  children: [
                    Text("2.577892 BTC",
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Okechi Emezue",
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(AppAssets.masterCard),
                        Text($strings.master,
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.white,
                                fontSize: 18.sp,
                                height: 0,
                                fontWeight: FontWeight.w400)),
                        Text($strings.virtual,
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.white,
                                height: 0,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400)),
                      ],
                    )
                  ],
                ),
              ],
            ).paddingAll(20),
          ],
        ),
      ),
    );
  }
}
