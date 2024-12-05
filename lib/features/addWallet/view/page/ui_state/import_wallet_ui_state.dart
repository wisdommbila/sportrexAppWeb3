import 'package:sportRex/core/commonLibs/common_libs.dart';

@immutable
class ImportWalletUiState {
  const ImportWalletUiState({
    this.isBusy = false,
    this.errorMsg = '',
  });

  final bool isBusy;
  final String errorMsg;

  ImportWalletUiState copy({
    bool? pinIsComplete,
    bool? isBusy,
    String? errorMsg,
  }) {
    return ImportWalletUiState(
      isBusy: isBusy ?? this.isBusy,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
