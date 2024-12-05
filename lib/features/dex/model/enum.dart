

enum SwapType {
  swapSource(metaData: (message: "You pay")),

  swapDestination(metaData: (message: "You get"));

  const SwapType({required this.metaData});

  final SwapMetaData metaData;
}




///Record used as a tiny data class
///Support equallity
typedef SwapMetaData = ({String message});
