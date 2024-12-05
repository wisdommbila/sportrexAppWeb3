import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/shared/app_icons.dart';

class MarketsPage extends StatelessWidget {
  static const String route = "/MarketsPage";

  const MarketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        bodyPadding: EdgeInsets.zero,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: $strings.markets,
          textColor: $styles.colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20 * $styles.scale),
            Text($strings.searchHere,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.greyMedium,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400))
                .paddingSymmetric(horizontal: 16),
            Gap(20 * $styles.scale),
            AppTextField(
              hintText: $strings.typeSomething,
            ).paddingSymmetric(horizontal: 16),
            Gap(20 * $styles.scale),
            Text(
              $strings.eth,
              style: $styles.text.body.copyWith(
                  color: $styles.colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            ).paddingSymmetric(horizontal: 16),
            Gap(15 * $styles.scale),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                  color: $styles.colors.primary100.withOpacity(0.25),
                  border: Border(
                    top: BorderSide(
                        width: 0.5, color: $styles.colors.primary100),
                    bottom: BorderSide(
                        width: 0.5, color: $styles.colors.primary100),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const AppIcon(
                        AppIcons.eth,
                        isSvg: false,
                        size: 36,
                      ),
                      Gap(20 * $styles.scale),
                      Text(
                        'SPT/BTC',
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Text("0.044 ETH",
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.greyMedium,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400)),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    decoration: BoxDecoration(
                        color: $styles.colors.meteorRed,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text("-3.88%",
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                  color: $styles.colors.primary100.withOpacity(0.25),
                  border: Border(
                    top: BorderSide(
                        width: 0.5, color: $styles.colors.primary100),
                    bottom: BorderSide(
                        width: 0.5, color: $styles.colors.primary100),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const AppIcon(
                        AppIcons.btc,
                        isSvg: false,
                        size: 36,
                      ),
                      Gap(20 * $styles.scale),
                      Text(
                        'ETH/BTC',
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Text("0.044 ETH",
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.greyMedium,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400)),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    decoration: BoxDecoration(
                        color: $styles.colors.green,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text("+3.88%",
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                  color: $styles.colors.primary100.withOpacity(0.25),
                  border: Border(
                    top: BorderSide(
                        width: 0.5, color: $styles.colors.primary100),
                    bottom: BorderSide(
                        width: 0.5, color: $styles.colors.primary100),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const AppIcon(
                        AppIcons.eth,
                        isSvg: false,
                        size: 36,
                      ),
                      Gap(20 * $styles.scale),
                      Text(
                        'SPT/BTC',
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Text("0.044 ETH",
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.greyMedium,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400)),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    decoration: BoxDecoration(
                        color: $styles.colors.meteorRed,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text("-3.88%",
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),


          ],
        ));
  }
}
