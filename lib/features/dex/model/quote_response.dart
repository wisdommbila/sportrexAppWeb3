import 'package:sportRex/core/util/appUtil/helper.dart';

class QuoteResponse {
  final double? toAmount;
  final int? gas;

  QuoteResponse({
    this.toAmount,
    this.gas,
  });

  QuoteResponse copyWith({
    double? toAmount,
    int? gas,
  }) =>
      QuoteResponse(
        toAmount: toAmount ?? this.toAmount,
        gas: gas ?? this.gas,
      );

  factory QuoteResponse.fromJson(Map<String, dynamic> json) => QuoteResponse(
        toAmount: json["toAmount"] is String
            ? convertToDouble(json["toAmount"])
            : json["toAmount"],
        gas: json["gas"],
      );

  Map<String, dynamic> toJson() => {
        "toAmount": toAmount,
        "gas": gas,
      };
}
