import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/dex/view/component/trades_radio_button.dart';
import 'package:sportRex/features/dex/view/page/market.dart';
import 'package:sportRex/features/dex/view/page/open_order.dart';
import 'package:sportRex/shared/app_icons.dart';

import '../buyAndSell_button.dart';

class TradeTab extends StatefulWidget {
  const TradeTab({Key? key}) : super(key: key);

  @override
  State<TradeTab> createState() => _TradeTabState();
}

class _TradeTabState extends State<TradeTab> {
  @override
  Widget build(BuildContext context) {
    return Skeleton(
      bodyPadding: EdgeInsets.zero,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(20),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: PurchaseTradeSection()),
                Expanded(child: PriceUpdateSection())
              ],
            ).paddingSymmetric(horizontal: 16),
            const Gap(25),
            AppBtn.from(
              bgColor: $styles.colors.secondary,
              expand: true,
              onPressed: () {
                
              },
              textColor: $styles.colors.white,
              text: $strings.buyBitcoin,
            ).paddingSymmetric(horizontal: 16),
            const Gap(25),
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 0.5, color: $styles.colors.primary100),
                  bottom:
                      BorderSide(width: 0.5, color: $styles.colors.primary100),
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text($strings.openOrder,
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600))
                        .paddingOnly(left: 10),
                    GestureDetector(
                      onTap: () {
                        $navigate.to(OpenOrder.route);
                      },
                      child: Text($strings.seeAll,
                          style: $styles.text.body.copyWith(
                              color: $styles.colors.greyMedium,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400)),
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 15),
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 15),
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
            const Gap(300),
          ],
        ),
      ),
      isBusy: false,
    );
  }
}



class PriceUpdateSection extends StatelessWidget {
  const PriceUpdateSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text($strings.priceSpt,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400))
                .paddingOnly(left: 10),
            Text($strings.amount,
                style: $styles.text.body.copyWith(
                    color: $styles.colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400)),
          ],
        ),
        Gap(10 * $styles.scale),
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Column(
              children: [
                CurrentPriceUpdate(),
                Gap(5),
                CurrentPriceUpdate(value: 0.65,),
                Gap(5),
                CurrentPriceUpdate(value: 0.3,),
                Gap(5),
                CurrentPriceUpdate(value: 0.85,),
                Gap(5),
                CurrentPriceUpdate(value: 0.45,),
                Gap(5),
                CurrentPriceUpdate(value: 0.85,),
              ],
            ),
            Gap(15 * $styles.scale),
            AppBtn.basic(
              onPressed: () {  },
              semanticLabel: '',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("0.00085743",
                      textAlign: TextAlign.center,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400)),
                  Gap(5 * $styles.scale),
                  const AppIcon(AppIcons.up,size: 12,)
                ],
              ),
            ),
            Gap(15 * $styles.scale),
             Column(

              children: [
                CurrentPriceUpdate(valueColor: $styles.colors.green,),
                const Gap(5),
                CurrentPriceUpdate(value: 0.65,valueColor: $styles.colors.green,),
                const Gap(5),
                CurrentPriceUpdate(value: 0.3,valueColor: $styles.colors.green,),
                const Gap(5),
                CurrentPriceUpdate(value: 0.85,valueColor: $styles.colors.green,),
                const Gap(5),
                CurrentPriceUpdate(value: 0.45,valueColor: $styles.colors.green,),
                const Gap(5),
                CurrentPriceUpdate(value: 0.85,valueColor: $styles.colors.green,),
              ],
            ),


          ],
        ).paddingOnly(left: 10)
      ],
    );
  }
}

class CurrentPriceUpdate extends StatelessWidget {
  final Color? valueColor;
  final double? value;

  const CurrentPriceUpdate({super.key, this.valueColor, this.value});

  @override
  Widget build(BuildContext context) {
    return AppBtn.basic(

      onPressed: () {  },
      semanticLabel: '',
      child: SizedBox(
        width: double.infinity,
        height: 22,
        child: Stack(
          children: [
            Transform(
              transform: Matrix4.rotationY(3.141),
              alignment: Alignment.center,
              child: LinearProgressIndicator(
                minHeight: 22,
                value:value?? 1,
                valueColor: AlwaysStoppedAnimation<Color>(
                    valueColor ?? $styles.colors.meteorRed),
                backgroundColor: $styles.colors.transparent,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("0.00085743 ",
                        textAlign: TextAlign.center,
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400))
                    .paddingOnly(left: 10),
                const Gap(5),
                Text("231",
                    textAlign: TextAlign.center,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PurchaseTradeSection extends StatefulWidget {
  const PurchaseTradeSection({
    super.key,
  });

  @override
  State<PurchaseTradeSection> createState() => _PurchaseTradeSectionState();
}

class _PurchaseTradeSectionState extends State<PurchaseTradeSection> {
  /// For test purpose--> (TODO:Please move to Controller)
  String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                $navigate.to(MarketsPage.route);
              },
              child: const AppIcon(
                AppIcons.exchange,
                size: 18,
              ),
            ),
            const Gap(10),
            Text("BTC/SPT",
                textAlign: TextAlign.center,
                style: $styles.text.body.copyWith(
                    color: $styles.colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600)),
            const Gap(10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
              decoration: BoxDecoration(
                  color: $styles.colors.meteorRed,
                  borderRadius: BorderRadius.circular(8)),
              child: Text("-3.88%",
                  style: $styles.text.body.copyWith(
                      color: $styles.colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
        const Gap(15),
        BuyAndSellButton(
          onChanged: (TradeType value) {},
        ),
        const Gap(15),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: $styles.colors.transparent,
            border: Border.all(color: $styles.colors.primary100),
            borderRadius: BorderRadius.circular(7),
          ),
          child: const CustomPriceDropDown(),
        ),
        const Gap(15),
        const AppTextField(hintText: "0.0005674"),
        const Gap(15),
        AppTextField(hintText: $strings.amountBtc),
        const Gap(15),
        TradeCustomRadio(
          options: const ["25%", "30%", "75%", "100%"],
          selectedOption: initialValue ?? "",
          activeColor: $styles.colors.secondary,
          inactiveColor: $styles.colors.greyMedium,
          onChanged: (String value) {
            setState(() {
              initialValue = value;
            });
          },
        ),
        const Gap(15),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text($strings.available,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.greyMedium,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400)),
                Text("0 SPT",
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.greyMedium,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            const Gap(18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text($strings.balance,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.greyMedium,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400)),
                Text("0 SPT",
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.greyMedium,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600)),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class CustomPriceDropDown extends StatelessWidget {
  const CustomPriceDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          value: "Market",
          selectedItemBuilder: (context) {
            return [
              "Market",
              "Sell Limit",
              "Limit",
              "Buy Limit",
            ].map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option,
                    textAlign: TextAlign.center,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400)),
              );
            }).toList();
          },
          style: $styles.text.body.copyWith(
              color: $styles.colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400),
          items: [
            "Market",
            "Sell Limit",
            "Limit",
            "Buy Limit",
          ].map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(option,
                      textAlign: TextAlign.center,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400)),
                  Divider(
                    // <-- Add the line separator here
                    color: $styles.colors.primary100.withOpacity(0.5),
                    thickness: 1,
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {}),
    );
  }
}
