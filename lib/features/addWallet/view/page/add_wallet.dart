import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/wallet_type.dart';
import 'package:sportRex/features/addWallet/view/page/import_other_wallet.dart';
import 'package:sportRex/features/addWallet/view/page/import_wallet.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/base_background.dart';

class AddWallet extends StatelessWidget {
  static const route = '/AddWallet';

  const AddWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        bodyPadding: EdgeInsets.zero,
        isAuthSkeleton: false,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: $strings.addWallet,
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
                  children: [
                    AppBtn(
                      onPressed: () {
                        _submit(ImportWalletType.multiCoin);
                      },
                      borderRadius: 10.r,
                      semanticLabel: "",
                      border: BorderSide(
                          color: $styles.colors.primary100, width: 0.2),
                      child: Row(
                        children: [
                          const AppIcon(
                            AppIcons.multicoin,
                            size: 40,
                          ),
                          Gap(20 * $styles.scale),
                          Text(
                            $strings.multiCoinWallet,
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Gap(30 * $styles.scale),
                    Container(
                      decoration: BoxDecoration(
                        color: $styles.colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: $styles.colors.primary100, width: 0.2),
                      ),
                      child: Column(
                        children: [
                          // AppBtn(
                          //   onPressed: () {
                          //     _submit(ImportWalletType.spt);
                          //   },
                          //   semanticLabel: "",
                          //   bgColor: $styles.colors.transparent,
                          //   child: Row(
                          //     children: [
                          //       const AppIcon(
                          //         AppIcons.spt,
                          //         size: 40,
                          //       ),
                          //       Gap(20 * $styles.scale),
                          //       Text(
                          //         $strings.spt,
                          //         style: $styles.text.body.copyWith(
                          //             color: $styles.colors.white,
                          //             fontSize: 20.sp,
                          //             fontWeight: FontWeight.w600),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // const HorizontalLine(),
                          // AppBtn(
                          //   onPressed: () {
                          //     _submit(ImportWalletType.btc);
                          //   },
                          //   semanticLabel: "",
                          //   bgColor: $styles.colors.transparent,
                          //   child: Row(
                          //     children: [
                          //       const AppIcon(
                          //         AppIcons.btc,
                          //         isSvg: false,
                          //         size: 40,
                          //       ),
                          //       Gap(20 * $styles.scale),
                          //       Text(
                          //         $strings.btc,
                          //         style: $styles.text.body.copyWith(
                          //             color: $styles.colors.white,
                          //             fontSize: 20.sp,
                          //             fontWeight: FontWeight.w600),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // const HorizontalLine(),

                          AppBtn(
                            onPressed: () {
                              $navigate.toWithParameters(
                                  ImportOtherWallet.route,
                                  args: ImportWalletType.eth);
                            },
                            semanticLabel: "",
                            bgColor: $styles.colors.transparent,
                            child: Row(
                              children: [
                                const AppIcon(
                                  AppIcons.eth,
                                  isSvg: false,
                                  size: 40,
                                ),
                                Gap(20 * $styles.scale),
                                Text(
                                  $strings.eth,
                                  style: $styles.text.body.copyWith(
                                      color: $styles.colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ).paddingSymmetric(horizontal: 16, vertical: 16))
          ],
        ));
  }

  _submit(ImportWalletType importWalletType) {
    $navigate.toWithParameters(ImportWallet.route, args: importWalletType);
  }
}
