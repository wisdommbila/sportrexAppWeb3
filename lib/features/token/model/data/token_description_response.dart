// To parse this JSON data, do
//
//     final tokenDescriptionResponse = tokenDescriptionResponseFromJson(jsonString);

import 'dart:convert';

TokenDescriptionResponse tokenDescriptionResponseFromJson(String str) =>
    TokenDescriptionResponse.fromJson(json.decode(str));

String tokenDescriptionResponseToJson(TokenDescriptionResponse data) =>
    json.encode(data.toJson());

class TokenDescriptionResponse {
  final bool? success;
  final String? message;
  final Data? data;

  TokenDescriptionResponse({
    this.success,
    this.message,
    this.data,
  });

  factory TokenDescriptionResponse.fromJson(Map<String, dynamic> json) =>
      TokenDescriptionResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? name;
  final String? symbol;
  final String? category;
  final String? description;
  final String? slug;
  final String? logo;
  final String? subreddit;
  final String? notice;
  final List<String>? tags;
  final List<String>? tagNames;
  final List<String>? tagGroups;
  final Urls? urls;
  final DataPlatform? platform;
  final DateTime? dateAdded;
  final String? twitterUsername;
  final int? isHidden;
  final dynamic dateLaunched;
  final List<ContractAddress>? contractAddress;
  final dynamic selfReportedCirculatingSupply;
  final dynamic selfReportedTags;
  final dynamic selfReportedMarketCap;
  final bool? infiniteSupply;
  final int? numMarketPairs;
  final int? maxSupply;
  final double? circulatingSupply;
  final int? totalSupply;
  final int? isActive;
  final int? cmcRank;
  final int? isFiat;
  final dynamic tvlRatio;
  final DateTime? lastUpdated;
  final Quote? quote;

  Data({
    this.id,
    this.name,
    this.symbol,
    this.category,
    this.description,
    this.slug,
    this.logo,
    this.subreddit,
    this.notice,
    this.tags,
    this.tagNames,
    this.tagGroups,
    this.urls,
    this.platform,
    this.dateAdded,
    this.twitterUsername,
    this.isHidden,
    this.dateLaunched,
    this.contractAddress,
    this.selfReportedCirculatingSupply,
    this.selfReportedTags,
    this.selfReportedMarketCap,
    this.infiniteSupply,
    this.numMarketPairs,
    this.maxSupply,
    this.circulatingSupply,
    this.totalSupply,
    this.isActive,
    this.cmcRank,
    this.isFiat,
    this.tvlRatio,
    this.lastUpdated,
    this.quote,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        category: json["category"],
        description: json["description"],
        slug: json["slug"],
        logo: json["logo"],
        subreddit: json["subreddit"],
        notice: json["notice"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        tagNames: json["tag-names"] == null
            ? []
            : List<String>.from(json["tag-names"]!.map((x) => x)),
        tagGroups: json["tag-groups"] == null
            ? []
            : List<String>.from(json["tag-groups"]!.map((x) => x)),
        urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
        platform: json["platform"] == null
            ? null
            : DataPlatform.fromJson(json["platform"]),
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
        twitterUsername: json["twitter_username"],
        isHidden: json["is_hidden"],
        dateLaunched: json["date_launched"],
        contractAddress: json["contract_address"] == null
            ? []
            : List<ContractAddress>.from(json["contract_address"]!
                .map((x) => ContractAddress.fromJson(x))),
        selfReportedCirculatingSupply: json["self_reported_circulating_supply"],
        selfReportedTags: json["self_reported_tags"],
        selfReportedMarketCap: json["self_reported_market_cap"],
        infiniteSupply: json["infinite_supply"],
        numMarketPairs: json["num_market_pairs"],
        maxSupply: json["max_supply"],
        circulatingSupply: json["circulating_supply"]?.toDouble(),
        totalSupply: json["total_supply"],
        isActive: json["is_active"],
        cmcRank: json["cmc_rank"],
        isFiat: json["is_fiat"],
        tvlRatio: json["tvl_ratio"],
        lastUpdated: json["last_updated"] == null
            ? null
            : DateTime.parse(json["last_updated"]),
        quote: json["quote"] == null ? null : Quote.fromJson(json["quote"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "category": category,
        "description": description,
        "slug": slug,
        "logo": logo,
        "subreddit": subreddit,
        "notice": notice,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "tag-names":
            tagNames == null ? [] : List<dynamic>.from(tagNames!.map((x) => x)),
        "tag-groups": tagGroups == null
            ? []
            : List<dynamic>.from(tagGroups!.map((x) => x)),
        "urls": urls?.toJson(),
        "platform": platform?.toJson(),
        "date_added": dateAdded?.toIso8601String(),
        "twitter_username": twitterUsername,
        "is_hidden": isHidden,
        "date_launched": dateLaunched,
        "contract_address": contractAddress == null
            ? []
            : List<dynamic>.from(contractAddress!.map((x) => x.toJson())),
        "self_reported_circulating_supply": selfReportedCirculatingSupply,
        "self_reported_tags": selfReportedTags,
        "self_reported_market_cap": selfReportedMarketCap,
        "infinite_supply": infiniteSupply,
        "num_market_pairs": numMarketPairs,
        "max_supply": maxSupply,
        "circulating_supply": circulatingSupply,
        "total_supply": totalSupply,
        "is_active": isActive,
        "cmc_rank": cmcRank,
        "is_fiat": isFiat,
        "tvl_ratio": tvlRatio,
        "last_updated": lastUpdated?.toIso8601String(),
        "quote": quote?.toJson(),
      };
}

class ContractAddress {
  final String? contractAddress;
  final ContractAddressPlatform? platform;

  ContractAddress({
    this.contractAddress,
    this.platform,
  });

  factory ContractAddress.fromJson(Map<String, dynamic> json) =>
      ContractAddress(
        contractAddress: json["contract_address"],
        platform: json["platform"] == null
            ? null
            : ContractAddressPlatform.fromJson(json["platform"]),
      );

  Map<String, dynamic> toJson() => {
        "contract_address": contractAddress,
        "platform": platform?.toJson(),
      };
}

class ContractAddressPlatform {
  final String? name;
  final Coin? coin;

  ContractAddressPlatform({
    this.name,
    this.coin,
  });

  factory ContractAddressPlatform.fromJson(Map<String, dynamic> json) =>
      ContractAddressPlatform(
        name: json["name"],
        coin: json["coin"] == null ? null : Coin.fromJson(json["coin"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "coin": coin?.toJson(),
      };
}

class Coin {
  final String? id;
  final String? name;
  final String? symbol;
  final String? slug;

  Coin({
    this.id,
    this.name,
    this.symbol,
    this.slug,
  });

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "slug": slug,
      };
}

class DataPlatform {
  final int? id;
  final String? name;
  final String? symbol;
  final String? slug;
  final String? tokenAddress;

  DataPlatform({
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.tokenAddress,
  });

  factory DataPlatform.fromJson(Map<String, dynamic> json) => DataPlatform(
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

class Quote {
  final Usd? usd;

  Quote({
    this.usd,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
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

class Urls {
  final List<String>? website;
  final List<String>? twitter;
  final List<String>? messageBoard;
  final List<String>? chat;
  final List<dynamic>? facebook;
  final List<String>? explorer;
  final List<String>? reddit;
  final List<String>? technicalDoc;
  final List<String>? sourceCode;
  final List<dynamic>? announcement;

  Urls({
    this.website,
    this.twitter,
    this.messageBoard,
    this.chat,
    this.facebook,
    this.explorer,
    this.reddit,
    this.technicalDoc,
    this.sourceCode,
    this.announcement,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        website: json["website"] == null
            ? []
            : List<String>.from(json["website"]!.map((x) => x)),
        twitter: json["twitter"] == null
            ? []
            : List<String>.from(json["twitter"]!.map((x) => x)),
        messageBoard: json["message_board"] == null
            ? []
            : List<String>.from(json["message_board"]!.map((x) => x)),
        chat: json["chat"] == null
            ? []
            : List<String>.from(json["chat"]!.map((x) => x)),
        facebook: json["facebook"] == null
            ? []
            : List<dynamic>.from(json["facebook"]!.map((x) => x)),
        explorer: json["explorer"] == null
            ? []
            : List<String>.from(json["explorer"]!.map((x) => x)),
        reddit: json["reddit"] == null
            ? []
            : List<String>.from(json["reddit"]!.map((x) => x)),
        technicalDoc: json["technical_doc"] == null
            ? []
            : List<String>.from(json["technical_doc"]!.map((x) => x)),
        sourceCode: json["source_code"] == null
            ? []
            : List<String>.from(json["source_code"]!.map((x) => x)),
        announcement: json["announcement"] == null
            ? []
            : List<dynamic>.from(json["announcement"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "website":
            website == null ? [] : List<dynamic>.from(website!.map((x) => x)),
        "twitter":
            twitter == null ? [] : List<dynamic>.from(twitter!.map((x) => x)),
        "message_board": messageBoard == null
            ? []
            : List<dynamic>.from(messageBoard!.map((x) => x)),
        "chat": chat == null ? [] : List<dynamic>.from(chat!.map((x) => x)),
        "facebook":
            facebook == null ? [] : List<dynamic>.from(facebook!.map((x) => x)),
        "explorer":
            explorer == null ? [] : List<dynamic>.from(explorer!.map((x) => x)),
        "reddit":
            reddit == null ? [] : List<dynamic>.from(reddit!.map((x) => x)),
        "technical_doc": technicalDoc == null
            ? []
            : List<dynamic>.from(technicalDoc!.map((x) => x)),
        "source_code": sourceCode == null
            ? []
            : List<dynamic>.from(sourceCode!.map((x) => x)),
        "announcement": announcement == null
            ? []
            : List<dynamic>.from(announcement!.map((x) => x)),
      };
}
