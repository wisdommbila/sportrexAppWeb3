import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/core/service/finger_print_service.dart';
import 'package:sportRex/core/util/appUtil/app_strings.dart';
import 'package:sportRex/features/dashBoard/view/page/dashboard.dart';
import 'package:sportRex/features/secure/controller/controllers.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/base_background.dart';

import '../../controller/secure_wallet_pin_controller.dart';

class LoginScreen extends HookConsumerWidget {
  static const route = '/loginScreen';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(secureWalletPinProvider);

    return Skeleton(
        bodyPadding: EdgeInsets.zero,
        backgroundColor: $styles.colors.primary,
        isAuthSkeleton: false,
        isBusy: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const AppIcon(AppIcons.back),
            onPressed: () => $navigate.back(),
          ),
        ),
        body: BaseImageBackground(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  $styles.scale.verticalSpace
                      .marginOnly(top: $styles.scale.reactive(40)!),
                  Text(
                    AppString.login,
                    style: $styles.text.h3,
                  ),
                  context.vSpace(14),
                  Text(
                    AppString.enterPassCodeToLogin,
                    style: $styles.text.title1.copyWith(
                        fontWeight: FontWeight.w400,
                        color: $styles.colors.white),
                  ),
                  context.vSpace(40),
                  SizedBox(
                    child: PinCodeTextField(
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      appContext: context,
                      length: 4,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textStyle: $styles.text.h2,
                      cursorColor: $styles.colors.primary,
                      obscureText: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.circle,
                        activeColor: const Color(0XFF57C3FF),
                        inactiveColor: $styles.colors.greyMedium,
                        disabledColor: $styles.colors.greyMedium,
                        selectedColor: $styles.colors.primary2,
                        inactiveFillColor: $styles.colors.primary,
                        activeFillColor: $styles.colors.primary2,
                        selectedFillColor: $styles.colors.primary2,
                        borderWidth: 0.5,
                        borderRadius: null,
                        fieldHeight: $styles.scale.reactive(80),
                        fieldWidth: $styles.scale.reactive(80),
                      ),
                      // validator: (value) {
                      //   if (value != controller.readPasscode()) {
                      //     return "Incorrect Passcode";
                      //   } else {
                      //     return "correct";
                      //   }
                      // },
                      animationDuration: const Duration(milliseconds: 300),
                      onChanged: (String val) {
                        controller.pin = val;
                        controller.onBtnActiveChange(val);
                        logger.log(Level.debug, val);
                      },
                    ),
                  ),
                  context.vSpace(38),
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         "Activate biometric login",
                  //         style: $styles.text.title1.copyWith(
                  //             fontWeight: FontWeight.w400,
                  //             fontSize: context.dx(14)),
                  //       ),
                  //       FlutterSwitch(
                  //         activeColor: $styles.colors.tertiary,
                  //         width: 40.0,
                  //         height: 20.0,
                  //         toggleSize: 18.0,
                  //         toggleColor: $styles.colors.primary,
                  //         value: false,
                  //         borderRadius: 30.0,
                  //         onToggle: (val) {},
                  //       ),
                  //     ],
                  //   ),
                  //   context.vSpace(118),

                  //   context.vSpace(48),
                  //   Center(child: buildIndicators(context)),

                  AppBtn.basic(
                      onPressed: () async {
                        final proceed = await locator
                            .get<FingerPrintService>()
                            .authenticate();

                        if (proceed) {
                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          $navigate.to(DashBoard.route);
                        }
                      },
                      semanticLabel: 'faceID/Fingerprint Verification',
                      child: Center(child: Image.asset(AppAssets.faceScan))),

                  context.vSpace(48),
                  AppBtn.from(
                    onPressed: controller.isBtnActive
                        ? () async {
                            await controller.readPasscode();

                            // print(controller.pin);
                            // print(controller.readPin);

                            if (controller.pin == controller.readPin) {
                              $navigate.to(DashBoard.route);
                            } else {
                              $toastService.showError("Incorrect Passcode");
                            }
                          }
                        : () {},
                    text: AppString.login,
                    isSecondary: true,
                    bgColor: controller.isBtnActive
                        ? $styles.colors.primary2
                        : $styles.colors.greyMedium,
                    expand: true,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Row buildIndicators(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: context.dy(4),
          width: context.dx(24),
          color: $styles.colors.primary2,
        ),
        const SizedBox(width: 8),
        Container(
          height: context.dy(4),
          width: context.dx(24),
          color: $styles.colors.primary2,
        ),
      ],
    );
  }
}
