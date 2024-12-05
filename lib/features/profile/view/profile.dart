import 'package:sportRex/core/route/routes.dart';
import 'package:sportRex/features/card/view/page/available_card.dart';
import 'package:sportRex/features/connections/view/connect_wallet_screen.dart';
import 'package:sportRex/features/profile/component/profile-item.dart';
import 'package:sportRex/shared/base_background.dart';

import '../../../core/commonLibs/common_libs.dart';

class Profile extends StatelessWidget {
  final bool? showBackBtn;
  const Profile({Key? key, this.showBackBtn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        bodyPadding: EdgeInsets.zero,
        bottomNavigationBar: SafeArea(
          child: AppBtn.from(
            bgColor: $styles.colors.secondary,
            onPressed: () {},
            textColor: $styles.colors.white,
            text: $strings.logout,
            minimumSize: const Size(double.infinity, 48),
            padding: EdgeInsets.zero,
          ).marginSymmetric(horizontal: 16),
        ),
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: showBackBtn ?? false,
          centerTitle: $strings.profile,
          textColor: $styles.colors.tertiary,
          actions: [
            SvgPicture.asset(
              "qrcode".svg,
              width: 24,
              height: 24,
            ).paddingOnly(right: 10)
          ],
        ),
        body: BaseImageBackground(children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileItem(
                    image: "wallet".svg,
                    title: $strings.wallet,
                    // subTitle: $strings.multiCoinWallet,
                    onPressed: () => $navigate.to(AppRoutes.wallet)),
                ProfileItem(
                    image: "cards".svg,
                    title: $strings.debitCards,
                    onPressed: () => $navigate.to(AvailableCard.route)),
                ProfileItem(
                    image: "connections".svg,
                    title: $strings.connections,
                    onPressed: () =>
                        $navigate.to(ConnectWalletScreen.routeName)),
                // ProfileItem(
                //     image: "referrals".svg,
                //     title: "Debit cards",
                //     onPressed: () {}),
                ProfileItem(
                    image: "security".svg,
                    title: $strings.security,
                    onPressed: () => $navigate.to(AppRoutes.security)),
                ProfileItem(
                    image: "pushNotification".svg,
                    title: $strings.pushNotification,
                    onPressed: () => $navigate.to(AppRoutes.pushNotification)),
                ProfileItem(
                    image: "priceAlerts".svg,
                    title: $strings.priceAlert,
                    onPressed: () => $navigate.to(AppRoutes.priceAlert)),
                // ProfileItem(
                //     image: "betSlip".svg,
                //     title: $strings.betSlips,
                //     onPressed: () {}),

                Text(
                  $strings.getSupport,
                  style: $styles.text.body.copyWith(
                      color: $styles.colors.tertiary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ).paddingAll(15),
                ProfileItem(
                    image: "sendEmail".svg,
                    title: $strings.sendEmails,
                    onPressed: () {}),
              ],
            ),
          ),
        ]));
  }
}
