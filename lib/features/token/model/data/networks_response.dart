class NetworksResponse {
  bool? success;
  String? message;
  List<NetworkData>? data;

  NetworksResponse({this.success, this.message, this.data});

  NetworksResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NetworkData>[];
      json['data'].forEach((v) {
        data!.add(NetworkData.fromJson(v));
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

class NetworkData {
  String? chain;
  String? name;
  String? symbol;
  int? decimals;
  List<String>? rpcUrls;
  Explorer? explorer;
  String? balance;

  NetworkData(
      {this.chain,
      this.name,
      this.symbol,
      this.decimals,
      this.rpcUrls,
      this.explorer,
      this.balance});

  NetworkData.fromJson(Map<String, dynamic> json) {
    chain = json['chain'];
    name = json['name'];
    symbol = json['symbol'];
    decimals = json['decimals'];
    rpcUrls = json['rpcUrls']?.cast<String>();
    explorer = json['explorer'] != null
        ? Explorer.fromJson(json['explorer'])
        : null;
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chain'] = chain;
    data['name'] = name;
    data['symbol'] = symbol;
    data['decimals'] = decimals;
    data['rpcUrls'] = rpcUrls;
    if (explorer != null) {
      data['explorer'] = explorer!.toJson();
    }
    data['balance'] = balance;
    return data;
  }
}

class Explorer {
  String? name;
  String? url;
  String? standard;
  String? icon;

  Explorer({this.name, this.url, this.standard, this.icon});

  Explorer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    standard = json['standard'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['standard'] = standard;
    data['icon'] = icon;
    return data;
  }
  
}
