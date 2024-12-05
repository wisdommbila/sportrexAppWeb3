import 'package:sportRex/core/util/colorUtils/color_utils.dart';

import '../../../../core/commonLibs/common_libs.dart';
import '../../../../core/util/appUtil/helper.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(20 * $styles.scale),
          Text("Name on card",
              style: $styles.text.body.copyWith(
                  color: $styles.colors.greyMedium,
                  fontSize: 14.sp,
                  height: 0,
                  fontWeight: FontWeight.w400)),
          Gap(5 * $styles.scale),
          Container(
            width: pageWidth(context),
            height: 48,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: $styles.colors.primary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: $styles.colors.primaryBorder,
                  width: 1,
                )),
            child: Text("Okechi Emezue",
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.greyMedium,
                        fontSize: 14.sp,
                        height: 0,
                        fontWeight: FontWeight.w400))
                .paddingAll(10),
          ).paddingSymmetric(horizontal: 10),
          Gap(10 * $styles.scale),
          Container(
            decoration: BoxDecoration(
              color: ColorUtils.parseHex("#011336"),
              border: Border.symmetric(
                horizontal:
                    BorderSide(color: $styles.colors.primaryBorder, width: 1),
              ),
            ),
            child: const Column(
              children: [
                _CardTile(
                  title: "Card number",
                  subTitle: "2345 2345 7895 0987",
                ),
                _CardTile(
                  title: "CVV",
                  subTitle: "591",
                ),
                _CardTile(
                  title: "Date created",
                  subTitle: "04-08-2021   10:00:31",
                ),
              ],
            ).paddingSymmetric(horizontal: 10, vertical: 20),
          ),
          Gap(40 * $styles.scale),
          AppBtn.from(
            bgColor: $styles.colors.meteorRed,
            onPressed: () {},
            textColor: $styles.colors.white,
            text: $strings.deleteCard,
            padding: EdgeInsets.zero,
            minimumSize: const Size(double.infinity, 48),
          ).marginSymmetric(horizontal: 16),
        ],
      ),
    );
  }
}

class _CardTile extends StatelessWidget {
  const _CardTile({Key? key, this.title, this.subTitle}) : super(key: key);

  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title ?? "",
            style: $styles.text.body.copyWith(
                color: $styles.colors.greyMedium,
                fontSize: 14.sp,
                height: 2,
                fontWeight: FontWeight.w400)),
        Row(
          children: [
            Text(subTitle ?? "",
                style: $styles.text.body.copyWith(
                    color: $styles.colors.tertiary,
                    fontSize: 14.sp,
                    height: 0,
                    fontWeight: FontWeight.w600)),
            const Gap(5),
            Icon(
              Icons.copy,
              size: 16,
              color: $styles.colors.greyMedium,
            )
          ],
        )
      ],
    ).paddingSymmetric(vertical: 5);
  }
}
