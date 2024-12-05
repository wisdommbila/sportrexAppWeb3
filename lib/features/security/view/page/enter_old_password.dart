import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/features/secure/controller/secure_wallet_pin_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sportRex/shared/base_background.dart';

class EnterOldPassword extends ConsumerWidget {
  static const route = '/enterOldPassword';

  const EnterOldPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(secureWalletPinProvider);

    return Skeleton(
        bodyPadding: EdgeInsets.zero,
        backgroundColor: $styles.colors.primary,
        isAuthSkeleton: false,
        isBusy: false,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: $strings.enterPasscode,
          textColor: $styles.colors.tertiary,
        ),
        body: BaseImageBackground(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  $styles.scale.verticalSpace
                      .marginOnly(top: $styles.scale.reactive(40)!),
                  Text(
                    $strings.enterOldPasscode,
                    textAlign: TextAlign.center,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.tertiary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
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
                      animationDuration: const Duration(milliseconds: 300),
                      onChanged: (String val) {
                        controller.pin = val;
                        controller.onBtnActiveChange(val);
                        logger.log(Level.debug, val);
                      },
                    ),
                  ),
                  Gap(150 * $styles.scale),
                  AppBtn.from(
                    onPressed: controller.isBtnActive
                        ? () => controller.compareOldPascode()
                        : () {},
                    text: $strings.continueTxt,
                    isSecondary: true,
                    expand: true,
                    bgColor: controller.isBtnActive
                        ? $styles.colors.primary2
                        : $styles.colors.greyMedium,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
