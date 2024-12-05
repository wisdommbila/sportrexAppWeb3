import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/features/token/model/data/chain_list_response.dart';




@immutable
class TokenUiState {
  const TokenUiState({
    this.isBusy = false,
    this.errorMsg = '',
    this.selectedNetwork,
  });

  final bool isBusy;
  final String errorMsg;
  final NetworkData? selectedNetwork;

  TokenUiState copy({
    bool? pinIsComplete,
    bool? isBusy,
    String? errorMsg,
    NetworkData? selectedNetwork,
  }) {
    return TokenUiState(
        isBusy: isBusy ?? this.isBusy,
        errorMsg: errorMsg ?? this.errorMsg,
        selectedNetwork: selectedNetwork ?? this.selectedNetwork);
  }
}
