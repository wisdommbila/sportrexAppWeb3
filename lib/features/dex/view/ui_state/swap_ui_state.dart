import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/features/dex/model/swap_coin.dart';

@immutable
class ConvertUiState {
  const ConvertUiState(
      {this.isBusy = false,
      this.errorMsg = '',
      this.swapSource,
      this.canApproveSwap = false,
      this.convertionMessage,
      this.isSwapBusy = false,
      this.swapDestination});

  final bool isBusy;
  final bool isSwapBusy;
  final bool canApproveSwap;
  final String errorMsg;
  final String? convertionMessage;

  final SwapData? swapSource;
  final SwapData? swapDestination;

  ConvertUiState copy(
      {bool? pinIsComplete,
      bool? isBusy,
      String? errorMsg,
      bool? isSwapBusy,
      String? convertionMessage,
      bool? canApproveSwap,
      SwapData? swapSource,
      SwapData? swapDestination}) {
    return ConvertUiState(
      swapDestination: swapDestination ?? this.swapDestination,
      swapSource: swapSource ?? this.swapSource,
      canApproveSwap: canApproveSwap ?? this.canApproveSwap,
      convertionMessage: convertionMessage ?? this.convertionMessage,
      isBusy: isBusy ?? this.isBusy,
      isSwapBusy: isSwapBusy ?? this.isSwapBusy,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
