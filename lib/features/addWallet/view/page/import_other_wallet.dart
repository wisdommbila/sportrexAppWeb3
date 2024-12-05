import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/wallet_type.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/features/addWallet/controller/import_wallet_controller.dart';
import 'package:sportRex/features/addWallet/view/component/my_indicator.dart';
import 'package:sportRex/features/addWallet/view/page/tabImportOtherWallet/page/address.dart';
import 'package:sportRex/features/addWallet/view/page/tabImportOtherWallet/page/keystore_json.dart';
import 'package:sportRex/features/addWallet/view/page/tabImportOtherWallet/page/pharse.dart';
import 'package:sportRex/features/addWallet/view/page/tabImportOtherWallet/page/private_key.dart';
import 'package:sportRex/shared/base_background.dart';

class ImportOtherWallet extends ConsumerStatefulWidget {
  static const route = '/ImportOtherWallet';

  final ImportWalletType? walletType;

  const ImportOtherWallet({Key? key, this.walletType}) : super(key: key);

  @override
  ConsumerState<ImportOtherWallet> createState() => _ImportOtherWalletState();
}

class _ImportOtherWalletState extends ConsumerState<ImportOtherWallet>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(vsync: this, length: 4);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy:
            ref.watch(importWalletController.select((value) => value.isBusy)),
        bodyPadding: EdgeInsets.zero,
        isAuthSkeleton: false,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: widget.walletType?.value,
          textColor: $styles.colors.white,
        ),
        backgroundColor: $styles.colors.primary,
        body: BaseImageBackground(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: pageHeight(context),
              child: Column(
                children: [
                  const Gap(5),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                          width: 0.5, color: $styles.colors.primary100),
                      bottom: BorderSide(
                          width: 0.5, color: $styles.colors.primary100),
                    )),
                    child: TabBar(
                        controller: _tabController,
                        unselectedLabelColor:
                            $styles.colors.white.withOpacity(0.2),
                        labelColor: $styles.colors.white,
                        labelStyle: $styles.text.bodySmall.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 14.sp),
                        unselectedLabelStyle: $styles.text.bodySmall.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 14.sp),
                        indicatorColor: $styles.colors.primary,
                        labelPadding: const EdgeInsets.all(1),
                        indicator: const MyTabIndicator(),
                        tabs: [
                          Tab(
                            text: $strings.phrase,
                          ),
                          Tab(
                            text: $strings.keystoreJson,
                          ),
                          Tab(
                            text: $strings.privateKey,
                          ),
                          Tab(
                            text: $strings.address,
                          ),
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        controller: _tabController,
                        children: [
                          PhraseWallet(
                            walletType: widget.walletType,
                          ),
                          KeystoreJson(
                            walletType: widget.walletType,
                          ),
                          PrivateKey(
                            walletType: widget.walletType,
                          ),
                          Address(
                            walletType: widget.walletType,
                          ),
                        ]),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
