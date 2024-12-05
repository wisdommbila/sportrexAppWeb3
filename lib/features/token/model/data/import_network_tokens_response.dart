import ' network_tokens_response.dart';

class ImportNetworkTokensResponse {
  bool? success;
  String? message;
  ImportedTokenData? data;

  ImportNetworkTokensResponse({this.success, this.message, this.data});

  ImportNetworkTokensResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? ImportedTokenData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ImportedTokenData {
  String? name;
  String? symbol;
  int? decimals;
  String? chain;
  String? contractAddress;
  String? logo;
  bool? isActive;
  Platform? platform;

  ImportedTokenData(
      {this.name,
      this.symbol,
      this.decimals,
      this.chain,
      this.logo,
      this.isActive,
      this.platform,
      this.contractAddress});

  ImportedTokenData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    decimals = json['decimals'];
    chain = json['chain'];
    logo = json['logo'] ?? "";
    platform =
        json['platform'] != null ? Platform.fromJson(json['platform']) : null;
    isActive = json['active'] ?? false;
    contractAddress = json['contract_address'];
  }

  ImportedTokenData copy({
    String? name,
    String? symbol,
    int? decimals,
    String? chain,
    String? contractAddress,
    String? logo,
    bool? isActive,
    Platform? platform,
  }) {
    return ImportedTokenData(
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        decimals: decimals ?? this.decimals,
        chain: chain ?? this.chain,
        contractAddress: contractAddress ?? this.contractAddress,
        logo: logo ?? this.logo,
        isActive: isActive ?? this.isActive,
        platform: platform ?? this.platform);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['decimals'] = this.decimals;
    data['chain'] = this.chain;
    data['logo'] = this.logo ?? "";
    data['active'] = this.isActive ?? "";
    if (this.platform != null) {
      data['platform'] = this.platform!.toJson();
    }
    data['contract_address'] = this.contractAddress;
    return data;
  }
}
