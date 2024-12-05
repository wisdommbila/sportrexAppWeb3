enum ImportWalletType {
  multiCoin(value: "MultiCoin Wallet"),
  spt(value: "SPT Wallet"),
  btc(value: "BTC Wallet"),
  eth(value: "ETH Wallet");

  const ImportWalletType({this.value});

  final String? value;
}
