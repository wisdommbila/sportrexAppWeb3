// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sportRex/features/dex/model/enum.dart';
import 'package:sportRex/features/dex/model/token_swap.dart';



class SwapData {
  final SwapTokens? swapTokens;
  final SwapType? swapType;
  SwapData({
     this.swapTokens,
    this.swapType,
  });

  SwapData copyWith({
    SwapTokens? swapTokens,
    SwapType? swapType,
  }) {
    return SwapData(
      swapTokens: swapTokens ?? this.swapTokens,
      swapType: swapType ?? this.swapType,
    );
  }

  @override
  String toString() => 'SwapData(swapTokens: $swapTokens, swapType: $swapType)';

  @override
  bool operator ==(covariant SwapData other) {
    if (identical(this, other)) return true;
  
    return 
      other.swapTokens == swapTokens &&
      other.swapType == swapType;
  }

  @override
  int get hashCode => swapTokens.hashCode ^ swapType.hashCode;
}
