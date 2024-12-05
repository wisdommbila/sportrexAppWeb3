import 'package:sportRex/core/commonLibs/common_libs.dart';

@immutable
class WalletTransactionsUiState {
  const WalletTransactionsUiState({
    this.isBusy = false,
    this.errorMsg = '',
  });

  final bool isBusy;
  final String errorMsg;

  WalletTransactionsUiState copy({
    bool? pinIsComplete,
    bool? isBusy,
    String? errorMsg,
  }) {
    return WalletTransactionsUiState(
      isBusy: isBusy ?? this.isBusy,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
