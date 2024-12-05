import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/config/dependecies.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/exception/app_exceptions.dart';
import 'package:sportRex/core/service/toast_service.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/features/token/model/data/token_data_source.dart';
import 'package:sportRex/features/token/model/data/token_prices_response.dart';
import 'package:sportRex/features/token/model/dataSource/token_service.dart';
import 'package:sportRex/features/token/view/ui_state/token_prices_ui_state.dart';

class TokenPriceHistoryController extends StateNotifier<TokenPricesUiState> {
  TokenPriceHistoryController({required this.networkDataSource})
      : super(const TokenPricesUiState(isBusy: false)) {
    _isBusy(true);
  }

  final TokenDataSource networkDataSource;

  TokenPricesResponse? _pricesResponse;
  TokenPricesResponse? get pricesResponse => _pricesResponse;
  ServerResponse? serverResponse;

  bool status = false;

  onSwitchChanged() {
    status = !status;
    reset();
  }

  Future<bool> fetchTokenPrices(String address, String chainId) async {
    try {
      // _isBusy(true);
      serverResponse =
          await networkDataSource.fetchTokenPriceHistory(address, chainId);

      // serverResponse = await networkDataSource.fetchTokenPriceHistory(
      //     "0xf20d962a6c8f70c731bd838a3a388d7d48fa6e15", "0x1");

      if (isObjectEmpty(serverResponse)) {
        reset();
        locator.get<ToastService>().showError("Please Try Again");
        return false;
      }

      if (!(serverResponse!.isSuccess!)) {
        reset();
        locator.get<ToastService>().showError(
            serverResponse?.defaultMessage ?? serverResponse!.errorMessage!);
        return false;
      }

      if ((serverResponse!.isSuccess!)) {
        _pricesResponse = TokenPricesResponse.fromJson(
            serverResponse!.payload! as Map<String, dynamic>);
        reset();
        return true;
      }

      reset();

      return true;
    } on AppException catch (error) {
      locator.get<ToastService>().showError(error.toString());
      reset();
      return false;
    } finally {
      reset();
    }
  }

  reset() {
    _isBusy(false);
  }

  _isBusy(bool loading) {
    state = state.copy(isBusy: loading);
  }
}

///for ui and state update calls
final tokenPriceHistoryController = StateNotifierProvider.autoDispose<
    TokenPriceHistoryController, TokenPricesUiState>((ref) {
  return TokenPriceHistoryController(
      networkDataSource: locator.get<TokenNetworkService>());
});
