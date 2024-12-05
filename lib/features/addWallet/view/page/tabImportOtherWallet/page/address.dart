import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/wallet_type.dart';
import 'package:sportRex/core/util/appUtil/validator.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/addWallet/controller/import_wallet_controller.dart';
import 'package:sportRex/features/dashBoard/view/page/dashboard.dart';
import 'package:sportRex/shared/paste_text.dart';

class Address extends ConsumerStatefulWidget {
  static const route = '/Address';

  final ImportWalletType? walletType;

  const Address({Key? key, this.walletType}) : super(key: key);

  @override
  ConsumerState<Address> createState() => _AddressState();
  
}

class _AddressState extends ConsumerState<Address>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();

  final addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(10 * $styles.scale),
          Text(
            $strings.address,
            style: $styles.text.body.copyWith(
                color: $styles.colors.greyMedium,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          Gap(10 * $styles.scale),
          AppTextField(
              suffixWidget: PasteText(
                onPasteText: (value) {
                  addressController.text = value;
                },
              ),
              minLines: 4,
              controller: addressController,
              validator: (value) => Validator.validateWalletAddress(value)),
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

      final procced = await ref
          .read(importWalletController.notifier)
          .importWalletWithAddress(addressController.text.toString().trim());
      if (procced) {
        $navigate.to(DashBoard.route);
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
