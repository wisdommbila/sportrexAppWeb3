import 'package:flutter_switch/flutter_switch.dart';
import 'package:sportRex/shared/base_background.dart';

import '../../../core/commonLibs/common_libs.dart';

class PushNotification extends StatefulWidget {
  const PushNotification({Key? key}) : super(key: key);

  @override
  State<PushNotification> createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  bool? _status = false;



  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: $strings.pushNotification,
          textColor: $styles.colors.tertiary,
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
                        "Allow Push Notifications",
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
                Text(
                  "You will be notified for sent and received transactions",
                  textAlign: TextAlign.center,
                  style: $styles.text.body.copyWith(
                      color: $styles.colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ).paddingSymmetric(horizontal: 20),
              ],
            )
          ],
        ));
  }
}

class _ItemToken {
  String? image;
  String? title;

  _ItemToken();
}
