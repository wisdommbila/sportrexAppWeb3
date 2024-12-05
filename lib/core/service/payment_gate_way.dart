import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sportRex/core/data/typdef.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';

class PaymentGateWay {
  String? buildTransakUrl(
      {String? network,
      required String amount,
      String? cryptoCurrency,
      required String address}) {
    String url = dotenv.get("TRANSAK_URL"), apikey = dotenv.get("TRANSAK_KEY");

    if (isEmpty(url) || isEmpty(apikey)) return null;

    StringMap parameter = {
      "apiKey": apikey,
      "walletAddress": address,
      "exchangeScreenTitle": "Buy Crypto on SportRex",
      "themeColor": "3333FF",
      "defaultCryptoCurrency": cryptoCurrency ?? "ETH",
      "defaultNetwork": network ?? "etherium",
      "defaultFiatCurrency": "USD",
      "defaultFiatAmount": amount
    };

    return url.encodeParams(parameter);
  }
}
