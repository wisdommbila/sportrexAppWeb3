import 'package:sportRex/core/util/appUtil/helper.dart';

class TokensSwap {
  final Map<String, SwapTokens>? tokens;

  TokensSwap({
    this.tokens,
  });

  List<SwapTokens> get tokenList =>
      isObjectEmpty(tokens) ? [] : tokens!.values.toList();

  TokensSwap copyWith({
    Map<String, SwapTokens>? tokens,
  }) =>
      TokensSwap(
        tokens: tokens ?? this.tokens,
      );

  factory TokensSwap.fromJson(Map<String, dynamic> json) => TokensSwap(
        tokens: Map.from(json["tokens"]!).map(
            (k, v) => MapEntry<String, SwapTokens>(k, SwapTokens.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "tokens": Map.from(tokens!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class SwapTokens {
  final String? address;
  final String? symbol;
  final int? decimals;
  final String? name;
  final String? logoUri;
  final List<dynamic>? tags;
  final bool? eip2612;

  SwapTokens({
    this.address,
    this.symbol,
    this.decimals,
    this.name,
    this.logoUri,
    this.tags,
    this.eip2612,
  });

  SwapTokens copyWith({
    String? address,
    String? symbol,
    int? decimals,
    String? name,
    String? logoUri,
    List<dynamic>? tags,
    bool? eip2612,
  }) =>
      SwapTokens(
        address: address ?? this.address,
        symbol: symbol ?? this.symbol,
        decimals: decimals ?? this.decimals,
        name: name ?? this.name,
        logoUri: logoUri ?? this.logoUri,
        tags: tags ?? this.tags,
        eip2612: eip2612 ?? this.eip2612,
      );

  factory SwapTokens.fromJson(Map<String, dynamic> json) => SwapTokens(
        address: json["address"],
        symbol: json["symbol"],
        decimals: json["decimals"],
        name: json["name"],
        logoUri: json["logoURI"],
        // tags: json["tags"],
        eip2612: json["eip2612"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "symbol": symbol,
        "decimals": decimals,
        "name": name,
        "logoURI": logoUri,
        "tags": tags,
        "eip2612": eip2612,
      };
}
