import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/features/connections/component/add_wallet_pill.dart';
import 'package:sportRex/features/connections/component/confirmation_bottomsheet.dart';
import 'package:sportRex/shared/base_background.dart';

import '../../../core/commonLibs/common_libs.dart';
import '../../../shared/dailog_sheet.dart';
import '../controller/scan_screen_controller.dart';

class ConnectionsWalletScreen extends ConsumerWidget {
  static const routeName = "ConnectionsWalletScreenRoute";

  const ConnectionsWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(scanScreenProvider);

    return Skeleton(
        isBusy: false,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: "Connections",
          textColor: $styles.colors.white,
          actions: [
            IconButton(
              onPressed: () => controller.scan(),
              icon: Icon(
                Icons.add,
                color: $styles.colors.white,
              ).paddingOnly(right: 10),
            )
          ],
        ),
        body: BaseImageBackground(
          children: [
            Column(
              children: [
                context.vSpace(24),
                AddWalletListPill(
                    title: "2 Total",
                    acctionText: "Disconnect all",
                    onPressed: () {
                      showSizeSheet(
                        context,
                        const ConfirmationBottomsheet(),
                      );
                    }),
                context.vSpace(24),
                AddWalletListPill(
                    img: AppAssets.sportrexLogo,
                    title: "Sportrex",
                    subTitle: "sportrex.io",
                    onPressed: () {
                      showSizeSheet(
                        context,
                        const ConfirmationBottomsheet(),
                      );
                    }),
              ],
            ),
          ],
        ).paddingZero);
  }
}
