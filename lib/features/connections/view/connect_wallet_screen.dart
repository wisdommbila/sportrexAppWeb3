import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/features/connections/component/add_wallet_pill.dart';
import 'package:sportRex/features/connections/view/connections_wallet_screen.dart';
import 'package:sportRex/shared/app_image.dart';
import 'package:sportRex/shared/base_background.dart';

import '../../../core/commonLibs/common_libs.dart';
import '../../../shared/app_icons.dart';

class ConnectWalletScreen extends StatefulWidget {
  static const routeName = "ConnectWalletScreenRoute";

  const ConnectWalletScreen({Key? key}) : super(key: key);

  @override
  State<ConnectWalletScreen> createState() => _ConnectWalletScreenState();
}

class _ConnectWalletScreenState extends State<ConnectWalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: "Connect wallet",
          textColor: $styles.colors.white,
          // actions: [
          //   Icon(
          //     Icons.add,
          //     color: $styles.colors.white,
          //   ).paddingOnly(right: 10)
          // ],
        ),
        body: BaseImageBackground(
          children: [
            Column(
              children: [
                context.vSpace(73),
                Container(
                  width: context.dy(64),
                  height: context.dy(64),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white),
                  child: AppImage(
                    image: AssetImage(AppAssets.sportrexLogo),
                    width: context.dx(53.33),
                    height: context.dx(53.33),
                  ),
                ),
                context.vSpace(32),
                Text(
                  "Sportrex NFT Marketplace wants to connect to your wallet",
                  textAlign: TextAlign.center,
                  style: $styles.text.h1.copyWith(
                      color: $styles.colors.white,
                      fontSize: 15.sp,
                      height: 2,
                      fontWeight: FontWeight.w600),
                ),
                context.vSpace(12),
                Text(
                  "https:sportrex.io",
                  textAlign: TextAlign.center,
                  style: $styles.text.body.copyWith(
                      color: $styles.colors.greyMedium,
                      fontSize: 12.sp,
                      height: 2,
                      fontWeight: FontWeight.w400),
                ),
                context.vSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "wallet".svg,
                      color: $styles.colors.greyMedium,
                      width: context.dx(16),
                      height: context.dx(16),
                    ),
                    context.hSpace(12),
                    Text(
                      "View your wallet balance and activity",
                      textAlign: TextAlign.center,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.greyMedium,
                          fontSize: 12.sp,
                          height: 2,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.approval,
                      color: $styles.colors.greyMedium,
                      width: context.dx(16),
                      height: context.dx(16),
                    ),
                    context.hSpace(12),
                    Text(
                      "Request approval for transactions",
                      textAlign: TextAlign.center,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.greyMedium,
                          fontSize: 12.sp,
                          height: 2,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                context.vSpace(62),
                AddWalletPill(
                    img: AppIcons.eth,
                    title: "My wallet",
                    subTitle: "0xACD363887ybfuyew....a2399haugdvwu",
                    onPressed: (value) {}),
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
                  $navigate.to(ConnectionsWalletScreen.routeName);
                },
                textColor: $styles.colors.white,
                text: "Connect",
                padding: EdgeInsets.zero,
              ).marginSymmetric(horizontal: 16),
            ),
          ],
        ));
  }
}

class _ItemToken {
  String? subtitle;
  String? title;
  bool? isPrimary;

  _ItemToken();
}
