// To parse this JSON data, do
//
//     final tokenDetailsResponse = tokenDetailsResponseFromJson(jsonString);

import 'dart:convert';

TokenDetailsResponse tokenDetailsResponseFromJson(String str) =>
    TokenDetailsResponse.fromJson(json.decode(str));

String tokenDetailsResponseToJson(TokenDetailsResponse data) =>
    json.encode(data.toJson());

class TokenDetailsResponse {
  final bool? success;
  final String? message;
  final List<TokenItem>? data;

  TokenDetailsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory TokenDetailsResponse.fromJson(Map<String, dynamic> json) =>
      TokenDetailsResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TokenItem>.from(json["data"]!.map((x) => TokenItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TokenItem {
  final String? chain;
  final String? tokenAddress;
  final String? name;
  final String? symbol;
  final dynamic logo;
  final dynamic thumbnail;
  final int? decimals;
  final String? balance;
  final bool? possibleSpam;
  final DatumQuote? quote;

  TokenItem({
    this.chain,
    this.tokenAddress,
    this.name,
    this.symbol,
    this.logo,
    this.thumbnail,
    this.decimals,
    this.balance,
    this.possibleSpam,
    this.quote,
  });

  factory TokenItem.fromJson(Map<String, dynamic> json) => TokenItem(
        chain: json["chain"],
        tokenAddress: json["token_address"] ?? json["contract_address"],
        name: json["name"],
        symbol: json["symbol"],
        logo: json["logo"],
        thumbnail: json["thumbnail"],
        decimals: json["decimals"],
        balance: json["balance"] ?? "0.0",
        possibleSpam: json["possible_spam"],
        quote:
            json["quote"] == null ? null : DatumQuote.fromJson(json["quote"]),
      );

  Map<String, dynamic> toJson() => {
        "chain": chain,
        "token_address": tokenAddress,
        "name": name,
        "symbol": symbol,
        "logo": logo,
        "thumbnail": thumbnail,
        "decimals": decimals,
        "balance": balance,
        "possible_spam": possibleSpam,
        "quote": quote?.toJson(),
      };
}

class DatumQuote {
  final int? id;
  final String? name;
  final String? symbol;
  final String? slug;
  final int? numMarketPairs;
  final DateTime? dateAdded;
  final List<String>? tags;
  final int? maxSupply;
  final double? circulatingSupply;
  final double? totalSupply;
  final Platform? platform;
  final int? isActive;
  final bool? infiniteSupply;
  final int? cmcRank;
  final int? isFiat;
  final dynamic selfReportedCirculatingSupply;
  final dynamic selfReportedMarketCap;
  final dynamic tvlRatio;
  final DateTime? lastUpdated;
  final QuoteQuote? quote;

  DatumQuote({
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.numMarketPairs,
    this.dateAdded,
    this.tags,
    this.maxSupply,
    this.circulatingSupply,
    this.totalSupply,
    this.platform,
    this.isActive,
    this.infiniteSupply,
    this.cmcRank,
    this.isFiat,
    this.selfReportedCirculatingSupply,
    this.selfReportedMarketCap,
    this.tvlRatio,
    this.lastUpdated,
    this.quote,
  });

  factory DatumQuote.fromJson(Map<String, dynamic> json) => DatumQuote(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        slug: json["slug"],
        numMarketPairs: json["num_market_pairs"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        maxSupply: json["max_supply"],
        circulatingSupply: json["circulating_supply"]?.toDouble(),
        totalSupply: json["total_supply"]?.toDouble(),
        platform: json["platform"] == null
            ? null
            : Platform.fromJson(json["platform"]),
        isActive: json["is_active"],
        infiniteSupply: json["infinite_supply"],
        cmcRank: json["cmc_rank"],
        isFiat: json["is_fiat"],
        selfReportedCirculatingSupply: json["self_reported_circulating_supply"],
        selfReportedMarketCap: json["self_reported_market_cap"],
        tvlRatio: json["tvl_ratio"],
        lastUpdated: json["last_updated"] == null
            ? null
            : DateTime.parse(json["last_updated"]),
        quote:
            json["quote"] == null ? null : QuoteQuote.fromJson(json["quote"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "slug": slug,
        "num_market_pairs": numMarketPairs,
        "date_added": dateAdded?.toIso8601String(),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "max_supply": maxSupply,
        "circulating_supply": circulatingSupply,
        "total_supply": totalSupply,
        "platform": platform?.toJson(),
        "is_active": isActive,
        "infinite_supply": infiniteSupply,
        "cmc_rank": cmcRank,
        "is_fiat": isFiat,
        "self_reported_circulating_supply": selfReportedCirculatingSupply,
        "self_reported_market_cap": selfReportedMarketCap,
        "tvl_ratio": tvlRatio,
        "last_updated": lastUpdated?.toIso8601String(),
        "quote": quote?.toJson(),
      };
}

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
  final DateTime? lastUpdated;

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
        lastUpdated: json["last_updated"] == null
            ? null
            : DateTime.parse(json["last_updated"]),
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
        "last_updated": lastUpdated?.toIso8601String(),
      };
}
