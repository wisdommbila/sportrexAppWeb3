
class VerifySeedPhraseResponse {
  bool? success;
  String? message;
  List<Data>? data;

  VerifySeedPhraseResponse({this.success, this.message, this.data});

  VerifySeedPhraseResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  WalletDetails? walletDetails;

  Data({this.name, this.walletDetails});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    walletDetails = json['walletDetails'] != null
        ?  WalletDetails.fromJson(json['walletDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (walletDetails != null) {
      data['walletDetails'] = walletDetails!.toJson();
    }
    return data;
  }
}

class WalletDetails {
  String? address;
  String? privatekey;

  WalletDetails({this.address, this.privatekey});

  WalletDetails.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    privatekey = json['privatekey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['privatekey'] = privatekey;
    return data;
  }
}