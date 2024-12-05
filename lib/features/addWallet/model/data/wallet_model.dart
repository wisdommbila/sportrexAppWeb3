class WalletModel {
  String? seedPhrase;
  String? privateKey;
  String? walletAddress;
  bool? status;
  String? walletName;
  String? chainID;

  WalletModel(
      {this.status,
      this.walletAddress,
      this.privateKey,
      this.seedPhrase,
      this.chainID,
      this.walletName});

  WalletModel.fromJson(Map<String, dynamic> json) {
    seedPhrase = json['seedPhrase'];
    privateKey = json['privateKey'];
    walletAddress = json['walletAddress'];
    status = json['status'];
    walletName = json['walletName'];
    chainID = json['chainID'];
  }

  WalletModel copy({
    String? seedPhrase,
    String? privateKey,
    String? walletAddress,
    bool? status,
    String? walletName,
    String? chainID,
  }) {
    return WalletModel(
        seedPhrase: seedPhrase ?? this.seedPhrase,
        privateKey: privateKey ?? this.privateKey,
        walletAddress: walletAddress ?? this.walletAddress,
        status: status ?? this.status,
        walletName: walletName ?? this.walletName,
        chainID: chainID ?? this.chainID);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seedPhrase'] = this.seedPhrase;
    data['privateKey'] = this.privateKey;
    data['walletAddress'] = this.walletAddress;
    data['status'] = this.status;
    data['walletName'] = this.walletName;
    data['chainID'] = this.chainID;

    return data;
  }
}
