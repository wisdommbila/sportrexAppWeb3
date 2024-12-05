import 'package:sportRex/core/commonLibs/common_libs.dart';

class OpenOrder extends StatelessWidget {
  static const String route = "/OpenOrder";

  const OpenOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        bodyPadding: EdgeInsets.zero,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: $strings.openOrder,
          textColor: $styles.colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20 * $styles.scale),

            Container(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                    color: $styles.colors.primary100.withOpacity(0.2),
                    border: Border(
                      top: BorderSide(
                          width: 0.5, color: $styles.colors.primary100),
                      bottom: BorderSide(
                          width: 0.5, color: $styles.colors.primary100),
                    )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                              decoration: BoxDecoration(
                                  color: $styles.colors.meteorRed,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text("Sell",
                                  style: $styles.text.body.copyWith(
                                      color: $styles.colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400)),
                            ),
                            const Gap(30),
                            Text("BTC/SPT",
                                style: $styles.text.body.copyWith(
                                    color: $styles.colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),



                        Text("08/09/21 10:00:31",
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [


                        Text($strings.priceSpt,
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.greyMedium,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400)),
                        const Gap(30),
                        Text("0.000456",
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text($strings.amount,
                                style: $styles.text.body.copyWith(
                                    color: $styles.colors.greyMedium,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400)),
                            const Gap(30),
                            Text("0/20",
                                style: $styles.text.body.copyWith(
                                    color: $styles.colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400))
                          ],
                        ),



                        Text("Cancel",
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                )),
            Container(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                    color: $styles.colors.primary100.withOpacity(0.2),
                    border: Border(
                      top: BorderSide(
                          width: 0.5, color: $styles.colors.primary100),
                      bottom: BorderSide(
                          width: 0.5, color: $styles.colors.primary100),
                    )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                              decoration: BoxDecoration(
                                  color: $styles.colors.green,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text("Buy",
                                  style: $styles.text.body.copyWith(
                                      color: $styles.colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400)),
                            ),
                            const Gap(30),
                            Text("BTC/SPT",
                                style: $styles.text.body.copyWith(
                                    color: $styles.colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),



                        Text("08/09/21 10:00:31",
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [


                        Text($strings.priceSpt,
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.greyMedium,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400)),
                        const Gap(30),
                        Text("0.000456",
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text($strings.amount,
                                style: $styles.text.body.copyWith(
                                    color: $styles.colors.greyMedium,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400)),
                            const Gap(30),
                            Text("0/20",
                                style: $styles.text.body.copyWith(
                                    color: $styles.colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400))
                          ],
                        ),



                        Text("Cancel",
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                )),
          ],
        ));
  }
}
