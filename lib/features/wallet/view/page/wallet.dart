import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/features/onboardingScreen/view/page/create_wallet_screen.dart';
import 'package:sportRex/features/wallet/component/wallet-item.dart';
import 'package:sportRex/features/wallet/controller/wallet_controller.dart';
import 'package:sportRex/features/wallet/view/component/edit_wallet_name.dart';
import 'package:sportRex/shared/base_background.dart';

import '../../../../core/commonLibs/common_libs.dart';
import '../../../../shared/dailog_sheet.dart';
import '../../../addWallet/model/data/wallet_model.dart';

class Wallet extends ConsumerStatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  ConsumerState<Wallet> createState() => _WalletState();
}

class _WalletState extends ConsumerState<Wallet> {
  final walletNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(walletController.notifier);
    return Skeleton(
        isBusy: ref.watch(walletController.select((value) => value.isBusy)),
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: $strings.wallet,
          textColor: $styles.colors.white,
          actions: [
            Icon(
              Icons.add,
              color: $styles.colors.white,
            ).paddingOnly(right: 10)
          ],
        ),
        body: BaseImageBackground(
          children: [
            Column(
              children: [
                if (controller.locallySavedWallets == null)
                  const SizedBox()
                else
                  ListView.builder(
                      itemCount: controller.locallySavedWallets?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return WalletItem(
                            title: controller.locallySavedWallets != null
                                ? controller
                                    .locallySavedWallets![index].walletName!
                                : "",
                            isPrimary:
                                controller.locallySavedWallets![index].status,
                            subTitle: controller.locallySavedWallets![index].walletAddress?.replaceRange(5, 30, "xxxxxxxx"),
                            onPressed: (value) {
                              print(value);
                              if (value == "default") {
                                controller.updateWalletStatus(
                                    controller.locallySavedWallets!, index);
                              } else {
                                walletNameController.text = controller.locallySavedWallets![index].walletName!;
                                showSizeSheet(
                                    context,
                                    EditWalletName(
                                        walletNameController:
                                            walletNameController,
                                        onSubmit: (name) async {
                                          $navigate.close();
                                          _changeWalletName(
                                              controller.locallySavedWallets!,
                                              index,
                                              name);
                                        }));
                              }
                            });
                      }),
              ],
            ),
            Positioned(
              bottom: 100.h,
              right: 0,
              left: 0,
              height: 50,
              child: AppBtn.from(
                bgColor: $styles.colors.secondary,
                onPressed: () {
                  $navigate.to(CreateWalletScreen.route);
                },
                textColor: $styles.colors.white,
                text: $strings.addWallet,
                padding: EdgeInsets.zero,
              ).marginSymmetric(horizontal: 16),
            ),
          ],
        ));
  }

  _changeWalletName(List<WalletModel> data, int index, String name) async {
    await ref
        .read(walletController.notifier)
        .updateWalletName(data, index, name);
  }
}
