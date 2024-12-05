import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/core/route/routes.dart';
import 'package:sportRex/core/util/appUtil/app_strings.dart';
import 'package:sportRex/features/addWallet/view/page/add_wallet.dart';
import 'package:sportRex/features/secure/view/page/login_screen.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/base_background.dart';

import '../../../../core/util/styleaUtils/app_style.dart';
import '../../../../shared/app_image.dart';

class CreateWalletScreen extends ConsumerStatefulWidget {
  static const route = '/createWalletScreen';

  const CreateWalletScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateWalletScreen> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends ConsumerState<CreateWalletScreen> {
  @override

  // final LocalStorageServiceImpls _storage = LocalStorageServiceImpls();

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        bodyPadding: EdgeInsets.zero,
        backgroundColor: $styles.colors.primary,
        isBusy: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Visibility(
            visible: $navigate.canPop(),
            child: IconButton(
              icon: const AppIcon(AppIcons.back),
              onPressed: () => $navigate.back(),
            ),
          ),
          actions: [
            TextButton(
                // onPressed: () async {
                //   final wallet = await locator
                //       .get<EtherDart>()
                //       .walletFromMemonicPhrase(
                //           "common steak glass aspect that announce fragile deliver produce cart people boil");
                //   print(wallet);
                // },
                onPressed: () => $navigate.to(LoginScreen.route),
                child: Text(
                  AppString.login,
                  style: $styles.text.btn.copyWith(color: $styles.colors.white),
                ))
          ],
        ),
        body: BaseImageBackground(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.vSpace(37),

                  Text(
                    AppString.create0rImportWallet,
                    style: $styles.text.h3,
                  ),
                  context.vSpace(14),

                  Text(
                    AppString.create0rImportWalletOrExisting,
                    style: $styles.text.title1.copyWith(
                        fontWeight: FontWeight.w400,
                        color: $styles.colors.greyMedium),
                  ),
                  context.vSpace(73.28),
                  Center(
                    child: AppImage(
                      image: AssetImage(AppAssets.backupWalletImage.png),
                      width: $styles.scale.reactive(232),
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [SvgPicture.asset(AppAssets.importWalletSvg)],
                  // ),
                  context.vSpace(56.23),

                  AppBtn.from(
                    onPressed: () {
                      $navigate.to(AppRoutes.backupYourWallet);
                    },
                    text: AppString.createWallet,
                    isSecondary: true,
                    bgColor: AppColors().primary2,
                    expand: true,
                  ),

                  context.vSpace(8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            $navigate.to(AddWallet.route);
                          },
                          child: Text(
                            AppString.addExisting,
                            style: $styles.text.btn.copyWith(
                                color: $styles.colors.white,
                                fontWeight: FontWeight.w600),
                          )),
                    ],
                  ),
                  context.vSpace(24),
                ],
              ),
            ),
          ],
        ));
  }

  _submit() {}
}
