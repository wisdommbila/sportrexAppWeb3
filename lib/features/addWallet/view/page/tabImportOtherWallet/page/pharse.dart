import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/wallet_type.dart';
import 'package:sportRex/core/util/appUtil/validator.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/addWallet/controller/import_wallet_controller.dart';
import 'package:sportRex/features/addWallet/model/data/import_keypharse_request.dart';
import 'package:sportRex/features/dashBoard/view/page/dashboard.dart';
import 'package:sportRex/shared/paste_text.dart';

class PhraseWallet extends ConsumerStatefulWidget {
  static const route = '/PhraseWallet';

  final ImportWalletType? walletType;

  const PhraseWallet({Key? key, this.walletType}) : super(key: key);

  @override
  ConsumerState<PhraseWallet> createState() => _PhraseWalletState();
}

class _PhraseWalletState extends ConsumerState<PhraseWallet>
    with AutomaticKeepAliveClientMixin {
  final nameController = TextEditingController();
  final seedPharseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final formKey = GlobalKey<FormState>();
  void initialStartUp() {
    nameController.text = "${widget.walletType?.value ?? '1'}1";
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialStartUp();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    seedPharseController.dispose();
    super.dispose();
  }

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
            $strings.name,
            style: $styles.text.body.copyWith(
                color: $styles.colors.greyMedium,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          Gap(10 * $styles.scale),
          AppTextField(
            controller: nameController,
            hintText: widget.walletType?.value ?? "",
          ),
          Gap(30 * $styles.scale),
          Text(
            $strings.backUpPhrase,
            style: $styles.text.body.copyWith(
                color: $styles.colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          Gap(10 * $styles.scale),
          AppTextField(
            suffixWidget: PasteText(
              onPasteText: (value) {
                seedPharseController.text = value;
              
              },
            ),
            controller: seedPharseController,
            validator: (value) => Validator.validateSeedPharse(value),
            minLines: 5,
          ),
          Gap(10 * $styles.scale),
          Text(
            $strings.seedPharseHint,
            style: $styles.text.body.copyWith(
                color: $styles.colors.lightGrey.withOpacity(0.8),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          ),
          Gap(100 * $styles.scale),
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
          .importWkeyPharse(ImportKeyPharseRequest(
              seedPhrase: seedPharseController.text.toString().trim()));

      if (proceed) {
        $navigate.to(DashBoard.route);
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
