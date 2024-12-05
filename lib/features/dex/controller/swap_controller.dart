import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/data/typdef.dart';
import 'package:sportRex/core/exception/app_exceptions.dart';
import 'package:sportRex/core/service/toast_service.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/core/util/debouncer.dart';
import 'package:sportRex/features/dex/model/data_source/network/dex_service.dart';
import 'package:sportRex/features/dex/model/dex_data_source.dart';
import 'package:sportRex/features/dex/model/enum.dart';
import 'package:sportRex/features/dex/model/quote_response.dart';
import 'package:sportRex/features/dex/model/swap_coin.dart';
import 'package:sportRex/features/dex/model/token_swap.dart';
import 'package:sportRex/features/dex/view/ui_state/swap_ui_state.dart';

class SwapController extends StateNotifier<ConvertUiState>
    implements SwapProcess {
  SwapController(this._dexDataSource) : super(const ConvertUiState()) {
    init();
  }

  final DexDataSource _dexDataSource;

  int get _getNetworkId => networkId;

  late int networkId;

  void setNetworkId(id) => networkId = id;

  ///Added comment
  final caculatePriceDebouner =
      DebouncerService(interval: const Duration(milliseconds: 300));

  //TODO:(author:precious) please find a better way
  final swapSourceController = TextEditingController();

  //TODO:(author:precious) please find a better way
  final swapDestinationController = TextEditingController();

  ///Get quote for the swap token
  /// it returns [QuoteResponse] object
  Future<QuoteResponse?> getQuote({
    required String source,
    required String desitination,
    required int amount,
  }) async {
    try {
      _isSwapBusy(true);

      final response = await _dexDataSource.getQuote(_getNetworkId,
          source: source,
          destination: desitination,
          amount: amount) as ServerResponse;

      if (isObjectEmpty(response.payload)) {
        locator.get<ToastService>().showError("Error occurred please refresh");
        return null;
      }

      return QuoteResponse.fromJson(response.payload as DynamicMap);
    } on AppException catch (error) {
      locator.get<ToastService>().showError(error.toString());

      return null;
    } finally {
      _isSwapBusy(false);
    }
  }

  void onPriceChange({required String amount, required SwapType swapType}) {
    caculatePriceDebouner.call(() {
      calculateSwapPrice(swapPrice: amount, swapType: swapType);
    }, false);
  }

  @override
  calculateSwapPrice(
      {required String swapPrice, required SwapType swapType}) async {
    if (swapType != SwapType.swapSource) {
      $toastService.showHint("Enter price from");
      return;
    }

    if (isEmpty(swapPrice)) return;

    final amount = convertMoneyToInt(swapPrice);

    if (amount == null) {
      $toastService.showHint("Enter price");
      return;
    }

    if (isObjectEmpty(state.swapSource?.swapTokens?.address)) {
      $toastService.showError("Select a token to swap from ");
      return;
    }

    if (isObjectEmpty(state.swapDestination?.swapTokens?.address)) {
      $toastService.showError("Select a token to swap to ");
      return;
    }

    updateConversionMessage("processing..");
    canApprove(false);

    final quote = await getQuote(
        source: state.swapSource?.swapTokens?.address ?? '',
        desitination: state.swapDestination?.swapTokens?.address ?? '',
        amount: amount);

    if (quote?.toAmount == null || quote!.toAmount! <= 0) {
      updateConversionMessage("");
      updateSwapDestinationPrice('0');
      canApprove(false);
      return;
    }

    final sourceRate = caculateSourceRate(rate: amount / quote.toAmount!);

    updateConversionMessage(
        "1 ${state.swapSource?.swapTokens?.symbol ?? ''} = ${moneyConverter(sourceRate.toString())} ${state.swapDestination?.swapTokens?.symbol ?? ''} ");

    updateSwapDestinationPrice(moneyConverter(quote.toAmount.toString()) ?? '');

    canApprove(true);
  }

  double caculateSourceRate({double range = 1, required double rate}) {
    return range / rate;
  }

  canApprove(bool canApprove) {
    state = state.copy(canApproveSwap: canApprove);
  }

  updateSwapDestinationPrice(String amount) {
    swapDestinationController.text = amount;
  }

  updateConversionMessage(String message) {
    state = state.copy(convertionMessage: message);
  }


  

  ///Change the swap psotition(you can do api call before changing)
  ///Remember to lock before changing
  void changeSwapPosition() {
    _clearControllers();
    updateConversionMessage("");
    state = state.copy(
        swapDestination:
            state.swapSource?.copyWith(swapType: SwapType.swapDestination),
        swapSource:
            state.swapDestination?.copyWith(swapType: SwapType.swapSource));
  }

  void _clearControllers() {
    swapDestinationController.clear();
    swapSourceController.clear();
  }

  @override
  init() {
    setNetworkId(1);

    ///you can add a default swap token at start for the network
    state = state.copy(
        swapSource: SwapData(
          swapType: SwapType.swapSource,
        ),
        swapDestination: SwapData(
          swapType: SwapType.swapDestination,
        ));
  }

  void updateSwapToken(SwapTokens swapToken, SwapType swapType) {
    updateConversionMessage("");
    switch (swapType) {
      case SwapType.swapSource:
        {
          swapSourceController.clear();
          state = state.copy(
              swapSource: SwapData(swapTokens: swapToken, swapType: swapType));
        }

      case SwapType.swapDestination:
        {
          swapDestinationController.clear();
          state = state.copy(
              swapDestination:
                  SwapData(swapTokens: swapToken, swapType: swapType));
        }
    }
  }

  @override
  void dispose() {
    swapDestinationController.dispose();
    swapSourceController.dispose();
    super.dispose();
  }

  _isBusy(bool value) {
    state = state.copy(isBusy: value);
  }

  _isSwapBusy(bool value) {
    state = state.copy(isSwapBusy: value);
  }

  reset() {
    _isBusy(false);
  }

  @override
  updateControllers(double price, SwapType swapType) {}
}

final swapController = StateNotifierProvider<SwapController, ConvertUiState>(
    (ref) => SwapController(locator.get<DexService>()));

abstract class SwapProcess {
  init();

  calculateSwapPrice({required String swapPrice, required SwapType swapType});

  updateControllers(double price, SwapType swapType);
}
