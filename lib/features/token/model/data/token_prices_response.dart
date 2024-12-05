// To parse this JSON data, do
//
//     final tokenPricesResponse = tokenPricesResponseFromJson(jsonString);

import 'dart:convert';

TokenPricesResponse tokenPricesResponseFromJson(String str) =>
    TokenPricesResponse.fromJson(json.decode(str));

String tokenPricesResponseToJson(TokenPricesResponse data) =>
    json.encode(data.toJson());

class TokenPricesResponse {
  final bool? success;
  final String? message;
  final Data? data;

  TokenPricesResponse({
    this.success,
    this.message,
    this.data,
  });

  factory TokenPricesResponse.fromJson(Map<String, dynamic> json) =>
      TokenPricesResponse(
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
  final List<double>? tokenPrices;

  Data({
    this.tokenPrices,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tokenPrices: json["tokenPrices"] == null
            ? []
            : List<double>.from(json["tokenPrices"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "tokenPrices": tokenPrices == null
            ? []
            : List<dynamic>.from(tokenPrices!.map((x) => x)),
      };
}
