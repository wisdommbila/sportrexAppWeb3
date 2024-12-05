import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/features/dex/model/token_swap.dart';
import 'package:fixed_collections/fixed_collections.dart';

@immutable
class SwapListUiState {
  const SwapListUiState({
    this.isBusy = false,
    this.errorMsg = '',
    final List<SwapTokens>? swapTokens,
    final List<SwapTokens>? fallbackSearchToken,
  })  : _swapTokens = swapTokens,
        _fallbackSearchToken = fallbackSearchToken;

  FixedList<SwapTokens> get allSwapTokens =>
      FixedList<SwapTokens>(_swapTokens ?? []);

      FixedList<SwapTokens> get fallbackList =>
      FixedList<SwapTokens>(_fallbackSearchToken ?? []);

  final bool isBusy;
  final List<SwapTokens>? _swapTokens;
  final List<SwapTokens>? _fallbackSearchToken;

  final String errorMsg;

  SwapListUiState copy({
    List<SwapTokens>? swapTokens,
    bool? isBusy,
    List<SwapTokens>? fallbackSearchToken,
    String? errorMsg,
  }) {
    return SwapListUiState(
      isBusy: isBusy ?? this.isBusy,
      fallbackSearchToken: fallbackSearchToken ?? _fallbackSearchToken,
      swapTokens: swapTokens ?? _swapTokens,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
