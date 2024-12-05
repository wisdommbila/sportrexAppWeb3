import 'package:sportRex/core/commonLibs/common_libs.dart';

@immutable
class NFTDetailsUiState {
  const NFTDetailsUiState({
    this.isBusy = false,
    this.errorMsg = '',
  });

  final bool isBusy;
  final String errorMsg;

  NFTDetailsUiState copy({
    bool? pinIsComplete,
    bool? isBusy,
    String? errorMsg,
  }) {
    return NFTDetailsUiState(
      isBusy: isBusy ?? this.isBusy,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
