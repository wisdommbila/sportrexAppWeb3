import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/core/route/routes.dart';
import 'package:sportRex/features/addWallet/view/page/import_wallet.dart';
import 'package:sportRex/features/token/controller/token_controller.dart';
import 'package:sportRex/features/token/model/data/chain_list_response.dart'
    as ccResponse;
import 'package:sportRex/features/token/model/data/token_detail_response.dart';
import 'package:sportRex/shared/shimmer.dart';

import '../../../../core/commonLibs/common_libs.dart';
import '../../../../core/config/constant.dart';
import '../../../../core/route/generate_route.dart';
import '../../../performTransaction/model/data/transactionType.dart';
import '../../../performTransaction/view/page/performTransaction.dart';
import 'line_chart.dart';

// ignore: must_be_immutable
class ItemToken extends ConsumerWidget {
  ItemToken({Key? key}) : super(key: key);

  List<TokenItem> tokens = [];
  List<TokenItem> tokensDefaults = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tokenDetailsController);
    final tokenController = ref.watch(tokenDetailsController.notifier);

    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      child: RefreshIndicator(
        displacement: 10,
        backgroundColor: $styles.colors.white,
        onRefresh: () async {
          await tokenController.fetchChainList();
          await tokenController.fetchTokens();
        },
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state.isBusy
                ? SizedBox(
                    height: context.dy(400),
                    child: const CustomScrollView(
                      slivers: [
                        LoadingIndicator(),
                      ],
                    ),
                  )
                : tokenController.tokenList == null
                    ? Center(
                        child: GestureDetector(
                            onTap: () => tokenController.fetchChainList(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: context.dy(150)),
                              child: const Text(
                                  "Unable to fetch data, tap to retry."),
                            )),
                      )
                    : tokenController.tokenList!.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              context.vSpace(30),
                              SvgPicture.asset(AppAssets.empty),
                              context.vSpace(12),
                              const Text("Looks like there’s nothing here."),
                              context.vSpace(20),
                              AppBtn.from(
                                bgColor: $styles.colors.secondary,
                                onPressed: () =>
                                    $navigate.to(ImportWallet.route),
                                expand: true,
                                textColor: $styles.colors.white,
                                text: $strings.importWallet,
                              ).marginSymmetric(horizontal: 16),
                            ],
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),

                            itemCount: tokenController.tokenList?.length ?? 0,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              tokensDefaults = tokenController.tokenList
                                  // ?.where((element) =>
                                  //     element.symbol?.toLowerCase() ==
                                  //     tokenController
                                  //         .state.selectedNetwork?.symbol
                                  //         ?.toLowerCase())
                                  // .toList()
                                  ??

                                  [];
                              return GestureDetector(
                                onTap: () => $navigate.toWithParameters(
                                    AppRoutes.tokenTransaction,
                                    args: TokenTransacData(
                                        chain: tokenController.tokenList?[index].chain ??
                                            "",
                                        symbol: tokenController.tokenList?[index].symbol ??
                                            "",
                                        balance: tokenController.tokenList?[index].balance ??
                                            "0.0",
                                        decimal: tokenController
                                                .tokenList?[index].decimals ??
                                            10,
                                        usdValue: tokenController
                                                .tokenList?[index]
                                                .quote
                                                ?.quote
                                                ?.usd
                                                ?.price ??
                                            0.0,
                                        tokenAddress: tokenController.tokenList?[index].chain ?? "")),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15.0,
                                      left: 15.0,
                                      right: 15.0,
                                      top: 0),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: const Color(0xff0E1648),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff182368),
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(9),
                                                child: Image.network(
                                                  tokensDefaults[index].logo ??
                                                      "",
                                                  width: context.dx(20),
                                                ),
                                              ),
                                              Gap(10 * $styles.scale),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    tokensDefaults[index]
                                                            .symbol ??
                                                        "",
                                                    style: $styles.text.body
                                                        .copyWith(
                                                            color: $styles
                                                                .colors
                                                                .tertiary,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                  if (tokensDefaults[index].quote !=
                                                      null)
                                                  Text(
                                                    "${tokensDefaults[index].quote?.quote?.usd?.percentChange1H?.toStringAsFixed(1)}%",
                                                    style: $styles.text.body
                                                        .copyWith(
                                                            color: $styles
                                                                .colors
                                                                .tertiary,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Gap(5 * $styles.scale),
                                          if (tokensDefaults[index].quote !=
                                              null)
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                height: 50,
                                                child: LineChartWidget(
                                                  color: tokensDefaults[index]
                                                          .quote!
                                                          .quote!
                                                          .usd!
                                                          .percentChange1H!
                                                          .toDouble()
                                                          .isNegative
                                                      ? const Color(0xffAF0C0C)
                                                      : const Color(0xff09CE35),
                                                  data: [
                                                    tokensDefaults[index]
                                                        .quote!
                                                        .quote!
                                                        .usd!
                                                        .percentChange1H!
                                                        .toDouble(),
                                                    tokensDefaults[index]
                                                        .quote!
                                                        .quote!
                                                        .usd!
                                                        .percentChange24H!
                                                        .toDouble(),
                                                    tokensDefaults[index]
                                                        .quote!
                                                        .quote!
                                                        .usd!
                                                        .percentChange7D!
                                                        .toDouble(),
                                                    tokensDefaults[index]
                                                        .quote!
                                                        .quote!
                                                        .usd!
                                                        .percentChange30D!
                                                        .toDouble(),
                                                    tokensDefaults[index]
                                                        .quote!
                                                        .quote!
                                                        .usd!
                                                        .percentChange60D!
                                                        .toDouble(),
                                                    tokensDefaults[index]
                                                        .quote!
                                                        .quote!
                                                        .usd!
                                                        .percentChange90D!
                                                        .toDouble(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          Gap(5 * $styles.scale),
                                          // if(tokensDefaults[index].balance!.isNotEmpty)
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(

                                                  "\$ ${convertToDollar(amount: double.parse(tokensDefaults[index].balance!.isNotEmpty ? tokensDefaults[index].balance! : "0.00"), decimal: tokensDefaults[index].decimals ?? 10, usdValue: 1000.0)}",

                                                  maxLines: 1,
                                                  style: $styles.text.body
                                                      .copyWith(
                                                          color:
                                                              $styles.colors
                                                                  .tertiary,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                Text(
                                                  "${convertToCoin(amount: double.parse(tokensDefaults[index].balance!.isNotEmpty ? tokensDefaults[index].balance! : "0.00"), decimal: tokensDefaults[index].decimals ?? 10)}",
                                                  maxLines: 1,
                                                  style: $styles.text.body
                                                      .copyWith(
                                                          color:
                                                              $styles.colors
                                                                  .tertiary,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),

          ],
        ),
      ),
    );
  }
}