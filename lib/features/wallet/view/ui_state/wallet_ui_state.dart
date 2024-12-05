import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/features/token/model/data/networks_response.dart';

@immutable
class WalletUiState {
  const WalletUiState({
    this.isBusy = false,
    this.errorMsg = '',
    this.selectedNetwork,
  });

  final bool isBusy;
  final String errorMsg;
  final NetworkData? selectedNetwork;

  WalletUiState copy({
    bool? pinIsComplete,
    bool? isBusy,
    String? errorMsg,
    NetworkData? selectedNetwork,
  }) {
    return WalletUiState(
        isBusy: isBusy ?? this.isBusy,
        errorMsg: errorMsg ?? this.errorMsg,
        selectedNetwork: selectedNetwork ?? this.selectedNetwork);
  }
}
