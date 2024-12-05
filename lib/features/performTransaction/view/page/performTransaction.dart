import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/core/service/clipboard.dart';
import 'package:sportRex/core/service/payment_gate_way.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/performTransaction/controller/perform_transaction_controller.dart';
import 'package:sportRex/features/performTransaction/view/component/receive_token.dart';
import 'package:sportRex/features/performTransaction/view/component/send_token.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/bottomsheet/bottom_sheet.dart';
import 'package:sportRex/shared/dailog_sheet.dart';

import '../../../../core/config/constant.dart';
import '../../../../core/route/generate_route.dart';
import '../../../../core/route/routes.dart';
import '../../../../shared/shimmer.dart';
import '../../../addWallet/view/page/import_wallet.dart';
import '../../../token/controller/token_controller.dart';
import '../../../token/model/data/token_detail_response.dart';
import '../../../token/view/component/line_chart.dart';
import '../../model/data/transactionType.dart';
import '../component/buy_token.dart';

class PerformTransaction extends ConsumerStatefulWidget {
  static const String route = "/PerformTransaction";

  final PerformTransactionType transactionType;

  const PerformTransaction({Key? key, required this.transactionType})
      : super(key: key);

  @override
  ConsumerState<PerformTransaction> createState() => _PerformTransactionState();
}

class _PerformTransactionState extends ConsumerState<PerformTransaction> {
  final addressController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy:
            ref.watch(performTransactionController.select((value) => value)),
        bodyPadding: EdgeInsets.zero,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: "",
          textColor: $styles.colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(20 * $styles.scale),
              Align(
                alignment: Alignment.topLeft,
                child: Text($strings.searchHere,
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.greyMedium,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400))
                    .paddingSymmetric(horizontal: 16),
              ),
              Gap(20 * $styles.scale),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) =>
                    AppTextField(
                  hintText: $strings.typeSomething,
                  onChanged: (value) {},
                ).paddingSymmetric(horizontal: 16),
              ),
              Gap(20 * $styles.scale),
              CryptoSearchResult(
                onPressed: () {
                  _performTransaction(
                    widget.transactionType,
                  );
                },
              ),
            ],
          ),
        ));
  }

  _performTransaction(
    PerformTransactionType transactionType,
  ) {
    switch (transactionType) {
      case PerformTransactionType.send:
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
        break;
      case PerformTransactionType.buy:
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
        break;
      case PerformTransactionType.receive:
        _receivedAddress(transactionType);

        break;
      default:
        break;
    }
  }

  _buyToken(String amount) async {
    final money = convertMoneyToDouble(amount);
    final address =
        await ref.read(performTransactionController.notifier).address;
    final url = locator.get<PaymentGateWay>().buildTransakUrl(
        amount: money.toInt().toString(), address: address ?? "");

    if (isEmpty(url)) {
      $toastService.showHint("Service Not available ",
          title: "Please try again");

      return;
    }

    launchUrl(url: url!);
  }

  _receivedAddress(
    PerformTransactionType transactionType,
  ) async {
    final address =
        await ref.read(performTransactionController.notifier).address;

    if (address == null) return;

    if (mounted) {
      showSizeSheet(
          context,
          ReceiveToken(
            title: transactionType.name,
            onSubmit: (String adderess) async {
              $navigate.back();
              _copyAddress(adderess);
            },
            address: address,
          ));
    }
  }

  _copyAddress(String address) async {
    AppClipboard.copy(address);
    $toastService.showSuccess("Just Copied Address");
  }

  _sendToken(String address, String amount) async {
    final proceed = await ref
        .read(performTransactionController.notifier)
        .sendCoin(address, amount);

    if (proceed) {
      if (mounted) {
        showSizeSheet(context, const SuccessBottomsheet());
      }
    }
  }


}

class CryptoSearchResult extends ConsumerStatefulWidget {
  final VoidCallback onPressed;

  const CryptoSearchResult({super.key, required this.onPressed});

  @override
  ConsumerState<CryptoSearchResult> createState() => _CryptoSearchResultState();
}

class _CryptoSearchResultState extends ConsumerState<CryptoSearchResult> {
  List<TokenItem> tokens = [];

  List<TokenItem> tokensDefaults = [];

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(tokenDetailsController);
    final tokenController = ref.watch(tokenDetailsController.notifier);
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: $styles.colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: $styles.colors.primary100, width: 0.2),
      ),
      child: Column(
        children: [
          AppBtn(
            onPressed: widget.onPressed,
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
          ListView.builder(
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

               return AppBtn(
                  onPressed: () => $navigate.toWithParameters(
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
                  semanticLabel: "",
                  bgColor: $styles.colors.transparent,
                  child: Row(
                    children: [
                      Image.network(
                        tokensDefaults[index].logo ??
                            "",
                        width: context.dx(40),
                      ),
                      Gap(20 * $styles.scale),
                      Expanded(
                        child: Text(
                          tokensDefaults[index]
                              .name ??
                              "",
                          style: $styles.text.body.copyWith(
                              color: $styles.colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                    ],
                  ),
                );
                // print("token lenght= ${tokens.length}");

              }),
        ],
      ),
    );
  }
}
