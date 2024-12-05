// To parse this JSON data, do
//
//     final walletTransactionsResponse = walletTransactionsResponseFromJson(jsonString);

import 'dart:convert';

WalletTransactionsResponse walletTransactionsResponseFromJson(String str) =>
    WalletTransactionsResponse.fromJson(json.decode(str));

String walletTransactionsResponseToJson(WalletTransactionsResponse data) =>
    json.encode(data.toJson());

class WalletTransactionsResponse {
  final bool? success;
  final String? message;
  final Data? data;

  WalletTransactionsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory WalletTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      WalletTransactionsResponse(
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

  Data({
    this.page,
    this.pageSize,
    this.cursor,
    this.result,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json["page"],
        pageSize: json["page_size"],
        cursor: json["cursor"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "page_size": pageSize,
        "cursor": cursor,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  final String? tokenName;
  final String? tokenSymbol;
  final dynamic tokenLogo;
  final String? tokenDecimals;
  final String? fromAddress;
  final dynamic fromAddressLabel;
  final String? toAddress;
  final dynamic toAddressLabel;
  final String? address;
  final String? blockHash;
  final String? blockNumber;
  final DateTime? blockTimestamp;
  final String? transactionHash;
  final int? transactionIndex;
  final int? logIndex;
  final String? value;
  final bool? possibleSpam;
  final String? valueDecimal;

  Result({
    this.tokenName,
    this.tokenSymbol,
    this.tokenLogo,
    this.tokenDecimals,
    this.fromAddress,
    this.fromAddressLabel,
    this.toAddress,
    this.toAddressLabel,
    this.address,
    this.blockHash,
    this.blockNumber,
    this.blockTimestamp,
    this.transactionHash,
    this.transactionIndex,
    this.logIndex,
    this.value,
    this.possibleSpam,
    this.valueDecimal,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        tokenName: json["token_name"],
        tokenSymbol: json["token_symbol"],
        tokenLogo: json["token_logo"],
        tokenDecimals: json["token_decimals"],
        fromAddress: json["from_address"],
        fromAddressLabel: json["from_address_label"],
        toAddress: json["to_address"],
        toAddressLabel: json["to_address_label"],
        address: json["address"],
        blockHash: json["block_hash"],
        blockNumber: json["block_number"],
        blockTimestamp: json["block_timestamp"] == null
            ? null
            : DateTime.parse(json["block_timestamp"]),
        transactionHash: json["transaction_hash"],
        transactionIndex: json["transaction_index"],
        logIndex: json["log_index"],
        value: json["value"],
        possibleSpam: json["possible_spam"],
        valueDecimal: json["value_decimal"],
      );

  Map<String, dynamic> toJson() => {
        "token_name": tokenName,
        "token_symbol": tokenSymbol,
        "token_logo": tokenLogo,
        "token_decimals": tokenDecimals,
        "from_address": fromAddress,
        "from_address_label": fromAddressLabel,
        "to_address": toAddress,
        "to_address_label": toAddressLabel,
        "address": address,
        "block_hash": blockHash,
        "block_number": blockNumber,
        "block_timestamp": blockTimestamp?.toIso8601String(),
        "transaction_hash": transactionHash,
        "transaction_index": transactionIndex,
        "log_index": logIndex,
        "value": value,
        "possible_spam": possibleSpam,
        "value_decimal": valueDecimal,
      };
}
