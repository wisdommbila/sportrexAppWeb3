import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/wallet_type.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/addWallet/view/page/import_other_wallet.dart';
import 'package:sportRex/shared/base_background.dart';

class ImportWallet extends StatelessWidget {
  static const route = '/ImportWallet';

  final ImportWalletType? walletType;

  const ImportWallet({Key? key, this.walletType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        bodyPadding: EdgeInsets.zero,
        isAuthSkeleton: false,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: $strings.importWallet,
          textColor: $styles.colors.white,
        ),
        backgroundColor: $styles.colors.primary,
        body: BaseImageBackground(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      $strings.name,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.greyMedium,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    Gap(10 * $styles.scale),
                    AppTextField(
                      hintText: walletType?.value ?? "",
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
                    const AppTextField(
                      minLines: 4,
                    ),
                    Gap(15 * $styles.scale),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        $strings.backUpPhraseInfo,
                        textAlign: TextAlign.center,
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.greyMedium,
                            fontSize: 12.8.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Gap(15 * $styles.scale),
                  ],
                ).paddingSymmetric(horizontal: 16, vertical: 16)),
            Positioned(
              bottom: 0.15.sh,
              right: 0,
              left: 0,
              child: AppBtn.from(
                bgColor: $styles.colors.secondary,
                onPressed: () {
                  _submit();
                },
                textColor: $styles.colors.white,
                text: $strings.addWallet,
              ).marginSymmetric(horizontal: 16),
            )
          ],
        ));
  }

  _submit() {
    $navigate.toWithParameters(ImportOtherWallet.route, args: walletType!);
  }
}
