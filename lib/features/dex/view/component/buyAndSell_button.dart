import 'package:sportRex/core/commonLibs/common_libs.dart';

class BuyAndSellButton extends StatefulWidget {
  final ValueChanged<TradeType> onChanged;

  const BuyAndSellButton({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State createState() => _BuyAndSellButtonState();
}

class _BuyAndSellButtonState extends State<BuyAndSellButton> {
  final buyOrSell = ValueNotifier<TradeType>(TradeType.buy);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: buyOrSell,
      builder: (BuildContext context, value, Widget? child) {
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  ///Changes the value of the trade type
                  if (value != TradeType.buy) {
                    buyOrSell.value = TradeType.buy;
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                      color: value == TradeType.buy
                          ? $styles.colors.green
                          : $styles.colors.primary100.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2)),
                  child: Text($strings.buy,
                      textAlign: TextAlign.center,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  ///Changes the value of the trade type
                  if (value != TradeType.sell) {
                    buyOrSell.value = TradeType.sell;
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                      color: value == TradeType.sell
                          ? $styles.colors.meteorRed
                          : $styles.colors.primary100.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2)),
                  child: Text($strings.sell,
                      textAlign: TextAlign.center,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

enum TradeType { buy, sell }
