// To parse this JSON data, do
//
//     final nftDetailsResponse = nftDetailsResponseFromJson(jsonString);

import 'dart:convert';

NftDetailsResponse nftDetailsResponseFromJson(String str) =>
    NftDetailsResponse.fromJson(json.decode(str));

String nftDetailsResponseToJson(NftDetailsResponse data) =>
    json.encode(data.toJson());

class NftDetailsResponse {
  final bool? success;
  final String? message;
  final Data? data;

  NftDetailsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory NftDetailsResponse.fromJson(Map<String, dynamic> json) =>
      NftDetailsResponse(
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
  final int? page;
  final int? pageSize;
  final dynamic cursor;
  final List<Result>? result;
  final String? status;

  Data({
    this.page,
    this.pageSize,
    this.cursor,
    this.result,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json["page"],
        pageSize: json["page_size"],
        cursor: json["cursor"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "page_size": pageSize,
        "cursor": cursor,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
        "status": status,
      };
}

class Result {
  final String? tokenAddress;
  final String? tokenId;
  final String? amount;
  final String? ownerOf;
  final String? tokenHash;
  final String? blockNumberMinted;
  final String? blockNumber;
  final bool? possibleSpam;
  final String? contractType;
  final String? name;
  final String? symbol;
  final String? tokenUri;
  final String? metadata;
  final DateTime? lastTokenUriSync;
  final DateTime? lastMetadataSync;
  final String? minterAddress;
  final NormalizedMetadata? normalizedMetadata;
  final bool? verifiedCollection;

  Result({
    this.tokenAddress,
    this.tokenId,
    this.amount,
    this.ownerOf,
    this.tokenHash,
    this.blockNumberMinted,
    this.blockNumber,
    this.possibleSpam,
    this.contractType,
    this.name,
    this.symbol,
    this.tokenUri,
    this.metadata,
    this.lastTokenUriSync,
    this.lastMetadataSync,
    this.minterAddress,
    this.normalizedMetadata,
    this.verifiedCollection,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        tokenAddress: json["token_address"],
        tokenId: json["token_id"],
        amount: json["amount"],
        ownerOf: json["owner_of"],
        tokenHash: json["token_hash"],
        blockNumberMinted: json["block_number_minted"],
        blockNumber: json["block_number"],
        possibleSpam: json["possible_spam"],
        contractType: json["contract_type"],
        name: json["name"],
        symbol: json["symbol"],
        tokenUri: json["token_uri"],
        metadata: json["metadata"],
        lastTokenUriSync: json["last_token_uri_sync"] == null
            ? null
            : DateTime.parse(json["last_token_uri_sync"]),
        lastMetadataSync: json["last_metadata_sync"] == null
            ? null
            : DateTime.parse(json["last_metadata_sync"]),
        minterAddress: json["minter_address"],
        normalizedMetadata: json["normalized_metadata"] == null
            ? null
            : NormalizedMetadata.fromJson(json["normalized_metadata"]),
        verifiedCollection: json["verified_collection"],
      );

  Map<String, dynamic> toJson() => {
        "token_address": tokenAddress,
        "token_id": tokenId,
        "amount": amount,
        "owner_of": ownerOf,
        "token_hash": tokenHash,
        "block_number_minted": blockNumberMinted,
        "block_number": blockNumber,
        "possible_spam": possibleSpam,
        "contract_type": contractType,
        "name": name,
        "symbol": symbol,
        "token_uri": tokenUri,
        "metadata": metadata,
        "last_token_uri_sync": lastTokenUriSync?.toIso8601String(),
        "last_metadata_sync": lastMetadataSync?.toIso8601String(),
        "minter_address": minterAddress,
        "normalized_metadata": normalizedMetadata?.toJson(),
        "verified_collection": verifiedCollection,
      };
}

class NormalizedMetadata {
  final String? name;
  final String? description;
  final dynamic animationUrl;
  final dynamic externalLink;
  final String? image;
  final List<dynamic>? attributes;

  NormalizedMetadata({
    this.name,
    this.description,
    this.animationUrl,
    this.externalLink,
    this.image,
    this.attributes,
  });

  factory NormalizedMetadata.fromJson(Map<String, dynamic> json) =>
      NormalizedMetadata(
        name: json["name"],
        description: json["description"],
        animationUrl: json["animation_url"],
        externalLink: json["external_link"],
        image: json["image"],
        attributes: json["attributes"] == null
            ? []
            : List<dynamic>.from(json["attributes"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "animation_url": animationUrl,
        "external_link": externalLink,
        "image": image,
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x)),
      };
}
