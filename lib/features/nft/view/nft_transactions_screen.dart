import 'package:flutter/cupertino.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/config/constant.dart';
import 'package:sportRex/features/addWallet/view/component/my_indicator.dart';
import 'package:sportRex/features/home/view/component/homeTransactionButton.dart';
import 'package:sportRex/features/nft/component/send_nft_botomsheet.dart';
import 'package:sportRex/features/nft/component/transaction_history.dart';
import 'package:sportRex/features/nft/view/send_nft_screen.dart';
import 'package:sportRex/shared/app_carousel.dart';
import 'package:sportRex/shared/dailog_sheet.dart';

import '../../../../core/util/appUtil/app_strings.dart';

class NFTTransactionScreen extends StatefulWidget {
  static const String route = "nfttransactionScreenRoute";
  const NFTTransactionScreen({Key? key}) : super(key: key);

  @override
  State<NFTTransactionScreen> createState() => _NFTTransactionScreenState();
}

class _NFTTransactionScreenState extends State<NFTTransactionScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(vsync: this, length: 3);
  List<String> sliderImages = List.generate(
    20,
    (index) => AppAssets.slider,
  );

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        backgroundColor: $styles.colors.primary,
        bodyPadding: EdgeInsets.zero,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(AppAssets.homeGradient))),
              child: SafeArea(
                left: false,
                right: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppCarousel(
                      sliderImages: sliderImages,
                    ),
                    BaseAppBar(
                      centerTitle: "Portfolio",
                      backBtnColor: $styles.colors.greyMedium,
                      showLeading: true,
                      textColor: $styles.colors.white,
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       "Portfolio",
                    //       style: $styles.text.body.copyWith(
                    //           color: $styles.colors.white,
                    //           fontSize: 18.sp,
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //   ],
                    // ),
                    Gap(2 * $styles.scale),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$1260.68",
                          style: $styles.text.body.copyWith(
                              color: $styles.colors.white,
                              fontSize: 36.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        const Icon(CupertinoIcons.eye)
                      ],
                    ).paddingSymmetric(horizontal: 0.08.sw),
                    Gap(15 * $styles.scale),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HomeTransactionButton(
                          btnTitle: $strings.send,
                          btnImage: AppAssets.send,
                          onPressed: () => $navigate.to(SendNftScreen.route),
                        ),
                        Gap(40 * $styles.scale),
                        HomeTransactionButton(
                          btnTitle: $strings.receive,
                          btnImage: AppAssets.buy,
                          onPressed: () => showSizeSheet(
                            context,
                            const RecieveNFTBottomsheet(),
                          ),
                        )
                      ],
                    ),
                    // Gap(14 * $styles.scale),
                  ],
                ),
              ),
            ),
            Gap(20 * $styles.scale),
            Expanded(
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(AppAssets.sportRexLargeLogo)),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: SvgPicture.asset(AppAssets.sportRexLargeLogo)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Gap(5),
                      TabBar(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.label,
                          unselectedLabelColor:
                              $styles.colors.white.withOpacity(0.2),
                          labelColor: $styles.colors.white,
                          labelStyle: $styles.text.bodySmall.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 18.sp),
                          unselectedLabelStyle: $styles.text.bodySmall.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 18.sp),
                          indicatorColor: $styles.colors.primary,
                          labelPadding: const EdgeInsets.only(right: 24),
                          indicator: const MyTabIndicator(height: 2),
                          isScrollable: true,
                          tabs: const [
                            Tab(
                              text: AppString.all,
                            ),
                            Tab(
                              text: AppString.deposit,
                            ),
                            Tab(
                              text: AppString.withdrawal,
                            ),
                          ]),
                      Expanded(
                        child: TabBarView(
                            physics: const BouncingScrollPhysics(),
                            controller: _tabController,
                            children: [
                              allTransaction(context),
                              allTransaction(context),
                              allTransaction(context),
                            ]),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget allTransaction(BuildContext context) {
    return ListView.builder(
        itemCount: dummyTransactionHistory.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => TransactionHistory(
              transactionHistory: dummyTransactionHistory[index],
            ));
  }
}
