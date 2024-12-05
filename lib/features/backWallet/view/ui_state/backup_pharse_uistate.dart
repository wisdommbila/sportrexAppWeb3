

import 'package:sportRex/core/commonLibs/common_libs.dart';

@immutable
class BackUpPhraseUiState {
  const BackUpPhraseUiState({
    this.isBusy = false,
    this.errorMsg = '',
  });

  final bool isBusy;
  final String errorMsg;

  BackUpPhraseUiState copy({
    bool? pinIsComplete,
    bool? isBusy,
    String? errorMsg,
  }) {
    return BackUpPhraseUiState(
      isBusy: isBusy ?? this.isBusy,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
