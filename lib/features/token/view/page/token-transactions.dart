import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/route/routes.dart';
import 'package:sportRex/core/service/clipboard.dart';
import 'package:sportRex/core/service/payment_gate_way.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/features/addWallet/view/component/my_indicator.dart';
import 'package:sportRex/features/home/view/component/homeTransactionButton.dart';
import 'package:sportRex/features/performTransaction/controller/perform_transaction_controller.dart';
import 'package:sportRex/features/performTransaction/view/component/buy_token.dart';
import 'package:sportRex/features/performTransaction/view/component/receive_token.dart';
import 'package:sportRex/features/performTransaction/view/component/send_token.dart';
import 'package:sportRex/features/token/view/component/dialog/filter-transaction-dialog.dart';
import 'package:sportRex/features/token/view/component/transaction-item.dart';
import 'package:sportRex/shared/bottomsheet/bottom_sheet.dart';
import 'package:sportRex/shared/shimmer.dart';

import '../../../../core/config/constant.dart';
import '../../../../core/route/generate_route.dart';
import '../../../../shared/app_carousel.dart';
import '../../../../shared/dailog_sheet.dart';
import '../../controller/wallet_transactions_comtroller.dart';

class TokenTransactions extends ConsumerStatefulWidget {
  final TokenTransacData token;
  const TokenTransactions({Key? key, required this.token}) : super(key: key);

  @override
  ConsumerState<TokenTransactions> createState() => _TokenTransactionsState();
}

class _TokenTransactionsState extends ConsumerState<TokenTransactions>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(vsync: this, length: 3);

  final addressController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    amountController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fetchDesc();
    super.initState();
  }

  fetchDesc() {
    unawaited(ref
        .read(walletTransactionsController.notifier)
        .fetchTransactons(widget.token.chain, widget.token.symbol));
  }

  List<String> sliderImages = List.generate(
    20,
    (index) => AppAssets.slider,
  );

  @override
  Widget build(BuildContext context) {
    final transactonDetails = ref.watch(walletTransactionsController.notifier);
    final state = ref.watch(walletTransactionsController);

    return Skeleton(
        isBusy:
            ref.watch(performTransactionController.select((value) => value)),
        backgroundColor: $styles.colors.primary,
        bodyPadding: EdgeInsets.zero,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(AppAssets.homeGradient))),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppCarousel(
                      sliderImages: sliderImages,
                    ),
                    BaseAppBar(
                      backBtnColor: $styles.colors.greyMedium,
                      showLeading: true,
                      // backPressed: () {},
                      toolbarHeight: 25,
                      textColor: $styles.colors.tertiary,
                      backgroundColor: $styles.colors.transparent,
                      centerTitle: widget.token.symbol,
                      actions: [
                        GestureDetector(
                                onTap: () => $navigate.toWithParameters(
                                    AppRoutes.tokenDetail,
                                    args: widget.token),
                                child: SvgPicture.asset("infographic".svg))
                            .paddingOnly(right: 16)
                      ],
                    ),
                    Gap(20 * $styles.scale),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            "\$ ${convertToDollar(amount: double.parse(widget.token.balance), decimal: widget.token.decimal, usdValue: widget.token.usdValue)}",
                            overflow: TextOverflow.ellipsis,
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.white,
                                fontSize: 36.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Expanded(child: Icon(CupertinoIcons.eye))
                      ],
                    ).paddingSymmetric(horizontal: 0.08.sw),
                    Gap(15 * $styles.scale),
                    Align(
                      alignment: Alignment.topLeft,
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
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
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
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ).paddingSymmetric(horizontal: 0.08.sw),
                    ),
                    Gap(30 * $styles.scale),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HomeTransactionButton(
                          btnTitle: $strings.send,
                          btnImage: AppAssets.send,
                          onPressed: () {
                            _sendTransaction();
                          },
                        ),
                        Gap(40 * $styles.scale),
                        HomeTransactionButton(
                          btnTitle: $strings.receive,
                          btnImage: AppAssets.receive,
                          onPressed: () {
                            _receivedAddress();
                          },
                        ),
                        Gap(40 * $styles.scale),
                        HomeTransactionButton(
                          btnTitle: $strings.buy,
                          btnImage: AppAssets.buy,
                          onPressed: () {
                            showbuyTokenDialog();
                          },
                        )
                      ],
                    ),
                    Gap(30 * $styles.scale),
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
                        children: [
                          Expanded(
                            child: TabBar(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                controller: _tabController,
                                indicatorSize: TabBarIndicatorSize.label,
                                unselectedLabelColor:
                                    $styles.colors.white.withOpacity(0.2),
                                labelColor: $styles.colors.white,
                                labelStyle: $styles.text.bodySmall.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp),
                                unselectedLabelStyle: $styles.text.bodySmall
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.sp),
                                indicatorColor: $styles.colors.primary,
                                labelPadding: const EdgeInsets.only(right: 50),
                                indicator: const MyTabIndicator(height: 5),
                                isScrollable: true,
                                tabs: [
                                  Tab(
                                    text: $strings.all.capitalizeFirst,
                                  ),
                                  Tab(
                                    text: $strings.deposit,
                                  ),
                                  Tab(
                                    text: $strings.withdrawal,
                                  ),
                                ]),
                          ),
                          GestureDetector(
                            onTap: () {
                              showSizeSheet(context, FilterTransactionDialog(
                                onSubmit: () {
                                  $navigate.back();
                                  // $navigate.to(SecureWalletScreen.route);
                                },
                              ));
                            },
                            child: SvgPicture.asset(
                              "filter".svg,
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 10),
                      Expanded(
                        child: TabBarView(
                            physics: const BouncingScrollPhysics(),
                            controller: _tabController,
                            children: [
                              state.isBusy
                                  ? const CustomScrollView(
                                      slivers: [
                                        LoadingIndicator(),
                                      ],
                                    )
                                  : transactonDetails
                                              .walletTransactionsResponse ==
                                          null
                                      ? const Center(
                                          child: Text("Unable to fetch data"))
                                      : transactonDetails
                                              .walletTransactionsResponse!
                                              .data!
                                              .result!
                                              .isEmpty
                                          ? const Center(
                                              child: Text("No transaction."))
                                          : ListView.builder(
                                              itemCount: transactonDetails
                                                  .walletTransactionsResponse!
                                                  .data!
                                                  .result!
                                                  .length,
                                              itemBuilder: (context, index) {
                                                var transactions = transactonDetails
                                                    .walletTransactionsResponse!
                                                    .data!
                                                    .result;
                                                return TransactionItem(
                                                  leftTitle:
                                                      transactions?[index]
                                                              .tokenSymbol ??
                                                          transactions?[index]
                                                              .tokenName ??
                                                          "",
                                                  rightTitle: convertToCoin(
                                                          amount: double.parse(
                                                              transactions![
                                                                      index]
                                                                  .value!
                                                                  .toString()),
                                                          decimal: int.parse(
                                                              transactions[
                                                                      index]
                                                                  .tokenDecimals
                                                                  .toString()))
                                                      .toString(),
                                                  rightValue: "",
                                                  leftValue: transactions[index]
                                                      .blockTimestamp
                                                      .toString(),
                                                  icon: transactions[index]
                                                              .fromAddress!
                                                              .toLowerCase() ==
                                                          transactonDetails
                                                              .walletAddress
                                                              .toLowerCase()
                                                      ? 'transaction-withdraw'
                                                          .svg
                                                      : 'transaction-deposit'
                                                          .svg,
                                                );
                                              }),
                              state.isBusy
                                  ? const CustomScrollView(
                                      slivers: [
                                        LoadingIndicator(),
                                      ],
                                    )
                                  : transactonDetails
                                              .walletTransactionsResponse ==
                                          null
                                      ? const Center(
                                          child: Text("Unable to fetch data"))
                                      : transactonDetails
                                              .walletTransactionsResponse!
                                              .data!
                                              .result!
                                              .where((element) =>
                                                  element.toAddress!
                                                      .toLowerCase() ==
                                                  transactonDetails
                                                      .walletAddress
                                                      .toLowerCase())
                                              .toList()
                                              .isEmpty
                                          ? const Center(
                                              child: Text(
                                                  "No transaction deposits."))
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: transactonDetails
                                                  .walletTransactionsResponse!
                                                  .data!
                                                  .result!
                                                  .where((element) =>
                                                      element.toAddress!
                                                          .toLowerCase() ==
                                                      transactonDetails
                                                          .walletAddress
                                                          .toLowerCase())
                                                  .toList()
                                                  .length,
                                              itemBuilder: (context, index) {
                                                var transactions = transactonDetails
                                                    .walletTransactionsResponse!
                                                    .data!
                                                    .result!
                                                    .where((element) =>
                                                        element.toAddress!
                                                            .toLowerCase() ==
                                                        transactonDetails
                                                            .walletAddress
                                                            .toLowerCase())
                                                    .toList();
                                                return TransactionItem(
                                                  leftTitle: transactions[index]
                                                          .tokenSymbol ??
                                                      transactions[index]
                                                          .tokenName ??
                                                      "",
                                                  rightTitle: convertToCoin(
                                                          amount: double.parse(
                                                              transactions[
                                                                      index]
                                                                  .value!
                                                                  .toString()),
                                                          decimal: int.parse(
                                                              transactions[
                                                                      index]
                                                                  .tokenDecimals
                                                                  .toString()))
                                                      .toString(),
                                                  rightValue: "",
                                                  leftValue: transactions[index]
                                                      .blockTimestamp
                                                      .toString(),
                                                  icon: transactions[index]
                                                              .fromAddress!
                                                              .toLowerCase() ==
                                                          transactonDetails
                                                              .walletAddress
                                                              .toLowerCase()
                                                      ? 'transaction-withdraw'
                                                          .svg
                                                      : 'transaction-deposit'
                                                          .svg,
                                                );
                                              }),
                              state.isBusy
                                  ? const CustomScrollView(
                                      slivers: [
                                        LoadingIndicator(),
                                      ],
                                    )
                                  : transactonDetails
                                              .walletTransactionsResponse ==
                                          null
                                      ? const Center(
                                          child: Text("Unable to fetch data"))
                                      : transactonDetails
                                              .walletTransactionsResponse!
                                              .data!
                                              .result!
                                              .where((element) =>
                                                  element.fromAddress!
                                                      .toLowerCase() ==
                                                  transactonDetails
                                                      .walletAddress
                                                      .toLowerCase())
                                              .toList()
                                              .isEmpty
                                          ? const Center(
                                              child: Text(
                                                  "No transaction withdrawals."))
                                          : ListView.builder(
                                              itemCount: transactonDetails
                                                  .walletTransactionsResponse!
                                                  .data!
                                                  .result!
                                                  .where((element) =>
                                                      element.fromAddress!
                                                          .toLowerCase() ==
                                                      transactonDetails
                                                          .walletAddress
                                                          .toLowerCase())
                                                  .toList()
                                                  .length,
                                              itemBuilder: (context, index) {
                                                var transactions = transactonDetails
                                                    .walletTransactionsResponse!
                                                    .data!
                                                    .result!
                                                    .where((element) =>
                                                        element.fromAddress!
                                                            .toLowerCase() ==
                                                        transactonDetails
                                                            .walletAddress
                                                            .toLowerCase())
                                                    .toList();
                                                return TransactionItem(
                                                  leftTitle: transactions[index]
                                                          .tokenSymbol ??
                                                      transactions[index]
                                                          .tokenName ??
                                                      "",
                                                  rightTitle: convertToCoin(
                                                          amount: double.parse(
                                                              transactions[
                                                                      index]
                                                                  .value!
                                                                  .toString()),
                                                          decimal: int.parse(
                                                              transactions[
                                                                      index]
                                                                  .tokenDecimals
                                                                  .toString()))
                                                      .toString(),
                                                  rightValue: "",
                                                  leftValue: transactions[index]
                                                      .blockTimestamp
                                                      .toString(),
                                                  icon: transactions[index]
                                                              .fromAddress!
                                                              .toLowerCase() ==
                                                          transactonDetails
                                                              .walletAddress
                                                              .toLowerCase()
                                                      ? 'transaction-withdraw'
                                                          .svg
                                                      : 'transaction-deposit'
                                                          .svg,
                                                );
                                              }),
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

  showbuyTokenDialog() {
    showSizeSheet(
        context,
        BuyToken(
          onSubmit: (value) {
            $navigate.back();
            amountController.clear();
            _buyToken(value);
          },
          amountcontroller: amountController,
        ));
  }

  _sendTransaction() {
    showSizeSheet(
        context,
        SendToken(
            addresscontroller: addressController,
            amountcontroller: amountController,
            onSubmit: (address, amount) async {
              amountController.clear();
              addressController.clear();
              $navigate.close();
              _sendToken(address, amount);
            }));
  }

  _buyToken(String amount) async {
    final money = convertMoneyToDouble(amount);
    final address =
        await ref.read(performTransactionController.notifier).address;
    final url = locator.get<PaymentGateWay>().buildTransakUrl(
        cryptoCurrency: widget.token.symbol,
        amount: money.toInt().toString(),
        address: address ?? "");

    if (isEmpty(url)) {
      $toastService.showHint("Service Not available ",
          title: "Please try again");

      return;
    }

    launchUrl(url: url!);
  }

  _sendToken(String address, String amount) async {
    final proceed =
        await ref.read(performTransactionController.notifier).sendToken(
              contractAddress: widget.token.tokenAddress,
              amount: amount,
              decimal: widget.token.decimal,
              hexAddress: address,
            );

    if (proceed) {
      if (mounted) {
        showSizeSheet(
            context,
            SuccessBottomsheet(
              subtitle:
                  "Your ${widget.token.symbol} was sent successfully",
            ));
      }
    }
  }

  _receivedAddress() async {
    final address =
        await ref.read(performTransactionController.notifier).address;

    if (address == null) return;

    if (mounted) {
      showSizeSheet(
          context,
          ReceiveToken(
            title: "Receive",
            onSubmit: (String adderess) async {
              $navigate.back();
              AppClipboard.copy(address);
              $toastService.showSuccess("Just Copied Address");
            },
            address: address,
          ));
    }
  }
}
