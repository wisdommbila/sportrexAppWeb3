import 'package:sportRex/features/token/model/data/import_network_tokens_response.dart';

class NetworkTokensResponse {
  bool? success;
  String? message;
  List<ImportedTokenData>? data;

  NetworkTokensResponse({this.success, this.message, this.data});

  NetworkTokensResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ImportedTokenData>[];
      json['data'].forEach((v) {
        data!.add(ImportedTokenData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Data {
//   String? chain;
//   String? name;
//   String? symbol;
//   String? logo;
//   String? contractAddress;
//   Platform? platform;
//
//   Data(
//       {this.chain,
//       this.name,
//       this.symbol,
//       this.logo,
//       this.contractAddress,
//       this.platform});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     chain = json['chain'];
//     name = json['name'];
//     symbol = json['symbol'];
//     logo = json['logo'];
//     contractAddress = json['contract_address'];
//     platform = json['platform'] != null
//         ? new Platform.fromJson(json['platform'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['chain'] = this.chain;
//     data['name'] = this.name;
//     data['symbol'] = this.symbol;
//     data['logo'] = this.logo;
//     data['contract_address'] = this.contractAddress;
//     if (this.platform != null) {
//       data['platform'] = this.platform!.toJson();
//     }
//     return data;
//   }
// }

class Platform {
  String? name;
  Coin? coin;

  Platform({this.name, this.coin});

  Platform.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    coin = json['coin'] != null ? new Coin.fromJson(json['coin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.coin != null) {
      data['coin'] = this.coin!.toJson();
    }
    return data;
  }
}

class Coin {
  String? id;
  String? name;
  String? symbol;
  String? slug;

  Coin({this.id, this.name, this.symbol, this.slug});

  Coin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['slug'] = this.slug;
    return data;
  }
}
