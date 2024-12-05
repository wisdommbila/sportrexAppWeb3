import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/config/dependecies.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/exception/app_exceptions.dart';
import 'package:sportRex/core/service/local_storage_service.dart';
import 'package:sportRex/core/service/toast_service.dart';
import 'package:sportRex/core/util/appUtil/app_strings.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/features/token/model/data/token_data_source.dart';
import 'package:sportRex/features/token/model/data/wallet_transactions_response.dart';
import 'package:sportRex/features/token/model/dataSource/token_service.dart';
import 'package:sportRex/features/token/view/ui_state/wallet_transaction_ui_state.dart';

class WalletTransactionsController
    extends StateNotifier<WalletTransactionsUiState> {
  WalletTransactionsController({required this.networkDataSource})
      : super(const WalletTransactionsUiState(isBusy: false)) {
    _isBusy(true);
  }

  final TokenDataSource networkDataSource;
  WalletTransactionsResponse? _walletTransactionsResponse;
  WalletTransactionsResponse? get walletTransactionsResponse =>
      _walletTransactionsResponse;
  ServerResponse? serverResponse;
  final LocalStorageServiceImpls _storage = LocalStorageServiceImpls();

  bool visible = true;
  onVisibleChanged() {
    visible = !visible;
    reset();
  }

  var walletAddress = "".toLowerCase();
  Future<bool> fetchTransactons(String chainId, String symbol) async {
    try {
      // _isBusy(true);
      walletAddress =
          await _storage.retrieveEncyptedData(AppString.walletAddressKey);
      serverResponse = await networkDataSource.fetchWalletTransactions(
          chainId, walletAddress, symbol);

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
        _walletTransactionsResponse = WalletTransactionsResponse.fromJson(
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

  Future<bool> sendTransactons(String chainId, String symbol) async {
    try {
      // _isBusy(true);

      // final response = await locator
      //     .get<EtherDart>().provider.sendTransaction(Credentials(), Transaction(
      //   from: EthereumAddress(addressBytes),
      //
      // ));

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
final walletTransactionsController = StateNotifierProvider.autoDispose<
    WalletTransactionsController, WalletTransactionsUiState>((ref) {
  return WalletTransactionsController(
      networkDataSource: locator.get<TokenNetworkService>());
});
