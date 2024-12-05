import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/wallet_type.dart';
import 'package:sportRex/core/util/appUtil/validator.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/addWallet/controller/import_wallet_controller.dart';
import 'package:sportRex/features/secure/view/page/secure_wallet_pin_screen.dart';
import 'package:sportRex/shared/paste_text.dart';

class PrivateKey extends ConsumerStatefulWidget {
  static const route = '/PrivateKey';

  final ImportWalletType? walletType;

  const PrivateKey({Key? key, this.walletType}) : super(key: key);

  @override
  ConsumerState<PrivateKey> createState() => _PrivateKeyState();
}

class _PrivateKeyState extends ConsumerState<PrivateKey>
    with AutomaticKeepAliveClientMixin {
  final privateKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   privateKeyController.text =
  //       "0x55cd7a591f83b10fed3440020d86490c7db2fb06cc984e7f0e483014b78b607a";
  //   super.initState();
  // }

  @override
  void dispose() {
    privateKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(10 * $styles.scale),
          Text(
            $strings.privateKey,
            style: $styles.text.body.copyWith(
                color: $styles.colors.greyMedium,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          Gap(10 * $styles.scale),
          AppTextField(
            suffixWidget: PasteText(
              onPasteText: (value) {
                privateKeyController.text = value;
              },
            ),
            minLines: 4,
            controller: privateKeyController,
            validator: (value) => Validator.validatePrivateKey(value),
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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final proceed = await ref
          .read(importWalletController.notifier)
          .importWithPrivateKey(privateKeyController.text.toString().trim());

      if (proceed) {
        $navigate.to(SecureWalletPinScreen.route);
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
