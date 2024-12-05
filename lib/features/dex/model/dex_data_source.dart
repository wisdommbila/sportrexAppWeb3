abstract class DexDataSource<T> {
  Future<T?> getSwapToken(int chainId);

  Future<T?> getQuote(int chainId,
      {required String source,
      required String destination,
      required int amount,
      bool includeGas = true});
}
