import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:sportRex/core/data/serverRespond.dart';

part 'token_prices_history_repository.g.dart';

class TokenPricesHistoryApi {
  static const String tokenDescription =
      "/api/v1/price-history-token-price?chainid=";
}

@RestApi()
abstract class TokenPricesHistoryRepository {
  factory TokenPricesHistoryRepository(Dio dio, {String baseUrl}) =
      _TokenPricesHistoryRepository;

  @POST(
      "${TokenPricesHistoryApi.tokenDescription}{chainId}&token_address={address}")
  Future<ServerResponse?> fetchTokenPriceHistory(
      @Path("chainId") String chainId, @Path("address") String address);
}
