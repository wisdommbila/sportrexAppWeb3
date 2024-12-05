


abstract class TokenDataSource<T> {
  Future<T?> fetchTokenDetails(String address, Map<String, dynamic> body);
  Future<T?> fetchTokenPriceHistory(String address, String chainId);

  Future<T?> fetchDescription(String name);
  Future<T?> fetchNetworks(String address);
  Future<T?> importNetworkTokens(
    String chainId,
    String address,
  );
  Future<T?> fetchNetworkTokens(String tokenName);
  Future<T?> fetchChainList(String address);

  Future<T?> fetchWalletTransactions(
      String chainId, String address, String symbol);
}


