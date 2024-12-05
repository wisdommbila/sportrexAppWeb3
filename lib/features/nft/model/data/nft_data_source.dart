abstract class NFTDataSource<T> {
  Future<T?> fetchNFTDetails(String address, String chainId);
}
