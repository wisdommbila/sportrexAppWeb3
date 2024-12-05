import 'package:flutter_switch/flutter_switch.dart';
import 'package:sportRex/features/security/view/page/enter_old_password.dart';
import 'package:sportRex/shared/base_background.dart';

import '../../../../core/commonLibs/common_libs.dart';

class Security extends StatefulWidget {
  const Security({Key? key}) : super(key: key);

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  bool? _status = false;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: $strings.security,
          textColor: $styles.colors.tertiary,
        ),
        body: BaseImageBackground(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () => $navigate.to(EnterOldPassword.route),
                  child: Container(
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
                          "Passcode",
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
                ),
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
                        "2 Factor Authentication",
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
                            // _status = val;
                          });
                        },
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 10),
                ),
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
                        "3 Factor Authenticator",
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.tertiary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      const Icon(
                        Icons.arrow_right,
                        size: 30,
                      )
                    ],
                  ).paddingSymmetric(horizontal: 10),
                ),
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
