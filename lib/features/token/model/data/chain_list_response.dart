// To parse this JSON data, do
//
//     final chainListResponse = chainListResponseFromJson(jsonString);

import 'dart:convert';


import 'package:sportRex/features/token/model/data/token_detail_response.dart';

ChainListResponse chainListResponseFromJson(String str) => ChainListResponse.fromJson(json.decode(str));


String chainListResponseToJson(ChainListResponse data) =>
    json.encode(data.toJson());

class ChainListResponse {
  final bool? success;
  final String? message;

   List<NetworkData>? data;


  ChainListResponse({
    this.success,
    this.message,
    this.data,
  });


  factory ChainListResponse.fromJson(Map<String, dynamic> json) => ChainListResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<NetworkData>.from(json["data"]!.map((x) => NetworkData.fromJson(x))),
  );


  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NetworkData {
  final String? chain;
  final String? name;
  final String? symbol;
  final int? decimals;
  final List<String>? rpcUrls;
  final Explorer? explorer;
  final String? balance;
  final DatumQuote? quote;
  final String? logo;

  NetworkData({
    this.chain,
    this.name,
    this.symbol,
    this.decimals,
    this.rpcUrls,
    this.explorer,
    this.balance,
    this.quote,
    this.logo,
  });


  factory NetworkData.fromJson(Map<String, dynamic> json) => NetworkData(
    chain: json["chain"],
    name: json["name"],
    symbol: json["symbol"],
    decimals: json["decimals"],
    rpcUrls: json["rpcUrls"] == null ? [] : List<String>.from(json["rpcUrls"]!.map((x) => x)),
    explorer: json["explorer"] == null ? null : Explorer.fromJson(json["explorer"]),
    balance: json["balance"],
    quote: json["quote"] == null ? null : DatumQuote.fromJson(json["quote"]),
    logo: json["logo"],
  );


  Map<String, dynamic> toJson() => {
        "chain": chain,
        "name": name,
        "symbol": symbol,
        "decimals": decimals,
        "rpcUrls":
            rpcUrls == null ? [] : List<dynamic>.from(rpcUrls!.map((x) => x)),
        "explorer": explorer?.toJson(),
        "balance": balance,
        "quote": quote?.toJson(),
        "logo": logo,
      };
}

class Explorer {
  final String? name;
  final String? url;
  final String? standard;
  final String? icon;

  Explorer({
    this.name,
    this.url,
    this.standard,
    this.icon,
  });

  factory Explorer.fromJson(Map<String, dynamic> json) => Explorer(
        name: json["name"],
        url: json["url"],
        standard: json["standard"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "standard": standard,
        "icon": icon,
      };
}


// class DatumQuote {
//   final int? id;
//   final String? name;
//   final String? symbol;
//   final String? slug;
//   final int? numMarketPairs;
//   final String? dateAdded;
//   final List<String>? tags;
//   final int? maxSupply;
//   final double? circulatingSupply;
//   final double? totalSupply;
//   final int? isActive;
//   final bool? infiniteSupply;
//   final Platform? platform;
//   final int? cmcRank;
//   final int? isFiat;
//   final dynamic selfReportedCirculatingSupply;
//   final dynamic selfReportedMarketCap;
//   final dynamic tvlRatio;
//   final String? lastUpdated;
//   final QuoteQuote? quote;
//
//   DatumQuote({
//     this.id,
//     this.name,
//     this.symbol,
//     this.slug,
//     this.numMarketPairs,
//     this.dateAdded,
//     this.tags,
//     this.maxSupply,
//     this.circulatingSupply,
//     this.totalSupply,
//     this.isActive,
//     this.infiniteSupply,
//     this.platform,
//     this.cmcRank,
//     this.isFiat,
//     this.selfReportedCirculatingSupply,
//     this.selfReportedMarketCap,
//     this.tvlRatio,
//     this.lastUpdated,
//     this.quote,
//   });
//
//   factory DatumQuote.fromJson(Map<String, dynamic> json) => DatumQuote(
//     id: json["id"],
//     name: json["name"],
//     symbol: json["symbol"],
//     slug: json["slug"],
//     numMarketPairs: json["num_market_pairs"],
//     dateAdded: json["date_added"],
//     tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
//     maxSupply: json["max_supply"],
//     circulatingSupply: json["circulating_supply"]?.toDouble(),
//     totalSupply: json["total_supply"]?.toDouble(),
//     isActive: json["is_active"],
//     infiniteSupply: json["infinite_supply"],
//     platform: json["platform"] == null ? null : Platform.fromJson(json["platform"]),
//     cmcRank: json["cmc_rank"],
//     isFiat: json["is_fiat"],
//     selfReportedCirculatingSupply: json["self_reported_circulating_supply"],
//     selfReportedMarketCap: json["self_reported_market_cap"],
//     tvlRatio: json["tvl_ratio"],
//     lastUpdated: json["last_updated"],
//     quote: json["quote"] == null ? null : QuoteQuote.fromJson(json["quote"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "symbol": symbol,
//     "slug": slug,
//     "num_market_pairs": numMarketPairs,
//     "date_added": dateAdded,
//     "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
//     "max_supply": maxSupply,
//     "circulating_supply": circulatingSupply,
//     "total_supply": totalSupply,
//     "is_active": isActive,
//     "infinite_supply": infiniteSupply,
//     "platform": platform?.toJson(),
//     "cmc_rank": cmcRank,
//     "is_fiat": isFiat,
//     "self_reported_circulating_supply": selfReportedCirculatingSupply,
//     "self_reported_market_cap": selfReportedMarketCap,
//     "tvl_ratio": tvlRatio,
//     "last_updated": lastUpdated,
//     "quote": quote?.toJson(),
//   };
// }


class Platform {
  final int? id;
  final String? name;
  final String? symbol;
  final String? slug;
  final String? tokenAddress;

  Platform({
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.tokenAddress,
  });

  factory Platform.fromJson(Map<String, dynamic> json) => Platform(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        slug: json["slug"],
        tokenAddress: json["token_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "slug": slug,
        "token_address": tokenAddress,
      };
}

class QuoteQuote {
  final Usd? usd;

  QuoteQuote({
    this.usd,
  });

  factory QuoteQuote.fromJson(Map<String, dynamic> json) => QuoteQuote(
        usd: json["USD"] == null ? null : Usd.fromJson(json["USD"]),
      );

  Map<String, dynamic> toJson() => {
        "USD": usd?.toJson(),
      };
}

class Usd {
  final double? price;
  final double? volume24H;
  final double? volumeChange24H;
  final double? percentChange1H;
  final double? percentChange24H;
  final double? percentChange7D;
  final double? percentChange30D;
  final double? percentChange60D;
  final double? percentChange90D;
  final double? marketCap;
  final double? marketCapDominance;
  final double? fullyDilutedMarketCap;
  final dynamic tvl;
  final String? lastUpdated;

  Usd({
    this.price,
    this.volume24H,
    this.volumeChange24H,
    this.percentChange1H,
    this.percentChange24H,
    this.percentChange7D,
    this.percentChange30D,
    this.percentChange60D,
    this.percentChange90D,
    this.marketCap,
    this.marketCapDominance,
    this.fullyDilutedMarketCap,
    this.tvl,
    this.lastUpdated,
  });

  factory Usd.fromJson(Map<String, dynamic> json) => Usd(
        price: json["price"]?.toDouble(),
        volume24H: json["volume_24h"]?.toDouble(),
        volumeChange24H: json["volume_change_24h"]?.toDouble(),
        percentChange1H: json["percent_change_1h"]?.toDouble(),
        percentChange24H: json["percent_change_24h"]?.toDouble(),
        percentChange7D: json["percent_change_7d"]?.toDouble(),
        percentChange30D: json["percent_change_30d"]?.toDouble(),
        percentChange60D: json["percent_change_60d"]?.toDouble(),
        percentChange90D: json["percent_change_90d"]?.toDouble(),
        marketCap: json["market_cap"]?.toDouble(),
        marketCapDominance: json["market_cap_dominance"]?.toDouble(),
        fullyDilutedMarketCap: json["fully_diluted_market_cap"]?.toDouble(),
        tvl: json["tvl"],
        lastUpdated: json["last_updated"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "volume_24h": volume24H,
        "volume_change_24h": volumeChange24H,
        "percent_change_1h": percentChange1H,
        "percent_change_24h": percentChange24H,
        "percent_change_7d": percentChange7D,
        "percent_change_30d": percentChange30D,
        "percent_change_60d": percentChange60D,
        "percent_change_90d": percentChange90D,
        "market_cap": marketCap,
        "market_cap_dominance": marketCapDominance,
        "fully_diluted_market_cap": fullyDilutedMarketCap,
        "tvl": tvl,
        "last_updated": lastUpdated,
      };
}
