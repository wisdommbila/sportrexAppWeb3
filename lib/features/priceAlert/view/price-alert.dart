import 'package:flutter_switch/flutter_switch.dart';
import 'package:sportRex/features/priceAlert/component/token-item.dart';
import 'package:sportRex/shared/base_background.dart';

import '../../../core/commonLibs/common_libs.dart';
import '../../../shared/app_icons.dart';

class PriceAlert extends StatefulWidget {
  const PriceAlert({Key? key}) : super(key: key);

  @override
  State<PriceAlert> createState() => _PriceAlertState();
}

class _PriceAlertState extends State<PriceAlert> {
  bool? _status = false;

  final _tokenList = [
    _ItemToken(title: $strings.spt, image: AppIcons.spt_white),
    _ItemToken(title: $strings.eth, image: AppIcons.eth),
    _ItemToken(title: $strings.btc, image: AppIcons.btc),
  ];

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: $strings.priceAlerts,
          textColor: $styles.colors.white,
          actions: [
            Icon(
              Icons.add,
              color: $styles.colors.tertiary,
            ).paddingOnly(right: 10)
          ],
        ),
        body: BaseImageBackground(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: $styles.colors.primary400,
                    border: Border.symmetric(
                        horizontal: BorderSide(
                            color: $styles.colors.primaryBorder, width: 0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Turn On Price Alerts",
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.tertiary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      FlutterSwitch(
                        activeColor: $styles.colors.tertiary,
                        width: 40.0,
                        height: 20.0,
                        toggleSize: 18.0,
                        toggleColor: $styles.colors.primary,
                        value: _status ?? false,
                        borderRadius: 30.0,
                        onToggle: (val) {
                          setState(() {
                            _status = val;
                          });
                        },
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 10),
                ),
                Gap(30 * $styles.scale),
                if (!_status!)
                  Text(
                    "Get alerts for price changes of your favourite cryptocurrencies",
                    textAlign: TextAlign.center,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ).paddingSymmetric(horizontal: 20),
                if(_status!)
                  Text(
                      "Swipe left to delete",
                      textAlign: TextAlign.right,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.white,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w400)).paddingOnly(bottom: 5),

                if (_status!)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _tokenList.length,
                      itemBuilder: (context, index) {
                        final image = _tokenList[index].image;
                        final title = _tokenList[index].title;
                        return Dismissible(
                            key: Key(_tokenList[index].title!),
                            direction: DismissDirection.endToStart,
                            background: ColoredBox(
                              color: $styles.colors.red,
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                ),
                              ),
                            ),
                            onDismissed: (DismissDirection direction) {
                              // Your deletion logic goes here.
                              setState(() {
                                _tokenList.removeAt(index);
                              });
                            },
                            child: TokenAlertItem(
                              image: image,
                              title: title,
                            ));
                      },
                    ),
                  ),
              ],
            )
          ],
        ));
  }
}

class _ItemToken {
  final image;
  String? title;

  _ItemToken({this.title, this.image});
}
