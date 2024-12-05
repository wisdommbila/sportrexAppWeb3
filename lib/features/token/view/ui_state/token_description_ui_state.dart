import 'package:sportRex/core/commonLibs/common_libs.dart';

@immutable
class TokenDescriptionUiState {
  const TokenDescriptionUiState({
    this.isBusy = false,
    this.errorMsg = '',
  });

  final bool isBusy;
  final String errorMsg;

  TokenDescriptionUiState copy({
    bool? pinIsComplete,
    bool? isBusy,
    String? errorMsg,
  }) {
    return TokenDescriptionUiState(
      isBusy: isBusy ?? this.isBusy,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
