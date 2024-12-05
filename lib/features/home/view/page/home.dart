import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/core/route/routes.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/features/addWallet/view/component/my_indicator.dart';
import 'package:sportRex/features/home/controller/controllers.dart';
import 'package:sportRex/features/home/model/data/tab_state.dart';
import 'package:sportRex/features/home/view/component/dailog/welcome_dailog.dart';
import 'package:sportRex/features/home/view/component/homeCustomeAppBar.dart';
import 'package:sportRex/features/home/view/component/homeTransactionButton.dart';
import 'package:sportRex/features/home/view/component/nft_tab.dart';
import 'package:sportRex/features/home/view/component/tokens.dart';
import 'package:sportRex/features/nft/view/nft_transactions_screen.dart';
import 'package:sportRex/features/performTransaction/model/data/transactionType.dart';
import 'package:sportRex/features/performTransaction/view/component/receive_token.dart';
import 'package:sportRex/features/performTransaction/view/page/performTransaction.dart';
import 'package:sportRex/features/search/view/page/send_nft.dart';
import 'package:sportRex/features/token/controller/token_controller.dart';
import 'package:sportRex/shared/dailog_sheet.dart';

import '../../../../core/service/clipboard.dart';
import '../../../../core/util/appUtil/app_strings.dart';
import '../../../../shared/app_carousel.dart';
import '../../../performTransaction/controller/perform_transaction_controller.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(vsync: this, length: 2);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      showSizeSheet(context, WelcomeDialog(
        onSubmit: () {
          $navigate.back();
          $navigate.to(AppRoutes.security);
        },
      ));
    });

    _handleTabChange();
  }

  _handleTabChange() {
    _tabController.addListener(() {
      ref.read(homeController.notifier).changeTabState(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> sliderImages = List.generate(
    20,
    (index) => AppAssets.slider,
  );

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () => $navigate.back(),
                  child: Text(
                    'Collection NFTs ',
                    style: $styles.text.body.copyWith(fontSize: context.dx(14)),
                  )),
              context.vSpace(10),
              GestureDetector(
                  onTap: () => $navigate.back(),
                  child: Text(
                    'Single NFT',
                    style: $styles.text.body.copyWith(fontSize: context.dx(14)),
                  )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokenState = ref.watch(tokenDetailsController);

    final tokenController = ref.watch(tokenDetailsController.notifier);
    return Skeleton(
        isBusy: false,
        backgroundColor: $styles.colors.primary,
        bodyPadding: EdgeInsets.zero,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    AppAssets.homeGradient,
                  ),
                ),
              ),
              child: SafeArea(
                // top: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppCarousel(
                      sliderImages: sliderImages,
                    ),
                    context.vSpace(16),
                    const HomeCustomAppBar().paddingSymmetric(horizontal: 16),
                    Gap(2 * $styles.scale),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        tokenState.isBusy
                            ? SizedBox(
                                width: context.dx(100),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    color: $styles.colors.greyMedium
                                        .withOpacity(0.5),
                                    height: 12,
                                  ),
                                ),
                              )
                            : tokenController.visible
                                ? Text(
                                    "\$ ${tokenController.balance}",
                                    overflow: TextOverflow.ellipsis,
                                    style: $styles.text.body.copyWith(
                                        color: $styles.colors.white,
                                        fontSize: 36.sp,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    "*******",
                                    overflow: TextOverflow.ellipsis,
                                    style: $styles.text.body.copyWith(
                                        color: $styles.colors.white,
                                        fontSize: 36.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                        Gap(30 * $styles.scale),
                        IconButton(
                            onPressed: () => tokenController.onVisibleChanged(),
                            icon: tokenController.visible
                                ? const Icon(CupertinoIcons.eye)
                                : const Icon(CupertinoIcons.eye_slash))
                      ],
                    ),
                    // Gap(5 * $styles.scale),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 25.h,
                        padding: horizontalPadding(size: 10),
                        decoration: BoxDecoration(
                            color: $styles.colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "+2.78%",
                              style: $styles.text.body.copyWith(
                                  color: $styles.colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            const Gap(5),
                            VerticalDivider(
                              color: $styles.colors.white,
                              thickness: 1,
                              width: 0,
                            ),
                            const Gap(5),
                            Text(
                              "+\$200%",
                              style: $styles.text.body.copyWith(
                                  color: $styles.colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ).paddingSymmetric(horizontal: 0.08.sw),
                    ),
                    Gap(20 * $styles.scale),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HomeTransactionButton(
                          onPressed: () {
                            // ref.watch(tokenDetailsController.notifier).fetchTokens();
                            if (ref.read(homeController
                                    .select((value) => value.tabState)) ==
                                TabState.nft) {
                              $navigate.to(
                                SendNftPage.route,
                              );

                              return;
                            }

                            $navigate.toWithParameters(PerformTransaction.route,
                                args: PerformTransactionType.send);
                          },
                          btnTitle: $strings.send,
                          btnImage: AppAssets.send,
                        ),
                        Gap(40 * $styles.scale),
                        HomeTransactionButton(
                            btnTitle: $strings.receive,
                            btnImage: (ref.read(homeController
                                        .select((value) => value.tabState)) ==
                                    TabState.nft)
                                ? AppAssets.nftReceive
                                : AppAssets.receive,
                            onPressed: () async {
                              if (ref.read(homeController
                                      .select((value) => value.tabState)) ==
                                  TabState.nft) {
                                final address = await ref
                                    .read(performTransactionController.notifier)
                                    .address;
                                if (address == null) return;

                                if (mounted) {
                                  showSizeSheet(
                                      context,
                                      ReceiveToken(
                                          title: "Receive Nft",
                                          address: address,
                                          onSubmit: (address) {
                                            $navigate.back();
                                            AppClipboard.copy(address);
                                            $toastService.showSuccess(
                                                "Just Copied Address");
                                          }));

                                  return;
                                }

                                $navigate.toWithParameters(
                                    PerformTransaction.route,
                                    args: PerformTransactionType.receive);
                              }
                            }),
                        Visibility(
                            visible: ref.watch(homeController
                                    .select((value) => value.tabState)) !=
                                TabState.nft,
                            child: Gap(40 * $styles.scale)),
                        AnimatedSize(
                          duration: $styles.times.fast,
                          child: Visibility(
                            visible: ref.watch(homeController
                                    .select((value) => value.tabState)) !=
                                TabState.nft,
                            child: HomeTransactionButton(
                              btnTitle: $strings.buy,
                              btnImage: AppAssets.buy,
                              onPressed: () {
                                $navigate.toWithParameters(
                                    PerformTransaction.route,
                                    args: PerformTransactionType.buy);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSize(
                          duration: $styles.times.fast,
                          child: Visibility(
                            visible: ref.watch(homeController
                                    .select((value) => value.tabState)) ==
                                TabState.nft,
                            child: TextButton(
                              onPressed: () {
                                $navigate.to(NFTTransactionScreen.route);
                              },
                              child: Text(
                                AppString.viewNftTransactions,
                                textAlign: TextAlign.center,
                                style: $styles.text.btn.copyWith(
                                    color: $styles.colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).paddingOnly(bottom: 16),
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
                      const Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TabBar(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              controller: _tabController,
                              indicatorSize: TabBarIndicatorSize.label,
                              unselectedLabelColor:
                                  $styles.colors.white.withOpacity(0.2),
                              labelColor: $styles.colors.white,
                              labelStyle: $styles.text.bodySmall.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 18.sp),
                              unselectedLabelStyle: $styles.text.bodySmall
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp),
                              indicatorColor: $styles.colors.primary,
                              labelPadding: const EdgeInsets.only(right: 40),
                              indicator: const MyTabIndicator(height: 6),
                              isScrollable: true,
                              tabs: [
                                Tab(
                                  text: $strings.token,
                                ),
                                Tab(
                                  text: $strings.nft,
                                ),
                              ]),
                          Visibility(
                            visible: ref.watch(homeController
                                    .select((value) => value.tabState)) ==
                                TabState.nft,
                            child: IconButton(
                                onPressed: () =>
                                    _showFilterDialog(),
                                icon: SvgPicture.asset(AppAssets.filter)),
                          )
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                            physics: const BouncingScrollPhysics(),
                            controller: _tabController,
                            children: [
                              const Tokens(),
                              NFTTab(),
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
}
