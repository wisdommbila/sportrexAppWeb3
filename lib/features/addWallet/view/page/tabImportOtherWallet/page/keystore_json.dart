import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/wallet_type.dart';
import 'package:sportRex/core/util/appUtil/validator.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/addWallet/controller/import_wallet_controller.dart';
import 'package:sportRex/features/dashBoard/view/page/dashboard.dart';
import 'package:sportRex/shared/paste_text.dart';

class KeystoreJson extends ConsumerStatefulWidget {
  static const route = '/KeystoreKJson';

  final ImportWalletType? walletType;

  const KeystoreJson({Key? key, this.walletType}) : super(key: key);

  @override
  ConsumerState<KeystoreJson> createState() => _KeystoreJsonState();
}

class _KeystoreJsonState extends ConsumerState<KeystoreJson>
    with AutomaticKeepAliveClientMixin {
  final keystoreController = TextEditingController();

  final passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    keystoreController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(10 * $styles.scale),
          Text(
            $strings.keystoreJson,
            style: $styles.text.body.copyWith(
                color: $styles.colors.greyMedium,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          Gap(10 * $styles.scale),
          AppTextField(
            suffixWidget: PasteText(
              onPasteText: (value) {
                keystoreController.text = value;
              },
            ),
            controller: keystoreController,
            minLines: 5,
            validator: (value) => Validator.validateEmptyField(value),
          ),
          Gap(25 * $styles.scale),
          Text(
            "Keystore Password",
            style: $styles.text.body.copyWith(
                color: $styles.colors.greyMedium,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          Gap(10 * $styles.scale),
          AppTextField(
            controller: passwordController,
            validator: (value) => Validator.validateEmptyField(value),
            isPassword: true,
          ),
          Gap(0.2.sh),
          AppBtn.from(
            bgColor: $styles.colors.secondary,
            minimumSize: const Size(double.infinity, 40),
            onPressed: () {
              _submit();
            },
            textColor: $styles.colors.white,
            text: $strings.importWallet,
          ),
        ],
      ).marginAll(16),
    );
  }

  _submit() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      final proceed = await ref
          .read(importWalletController.notifier)
          .importWWalletFromKeyStore(keystoreController.text.toString().trim(),
              passwordController.text.toString().trim());

      if (proceed) {
        $navigate.to(DashBoard.route);
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
