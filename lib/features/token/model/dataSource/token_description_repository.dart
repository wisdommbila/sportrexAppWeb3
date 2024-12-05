import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:sportRex/core/data/serverRespond.dart';

part 'token_description_repository.g.dart';

class TokenDescriptionApi {
  static const String tokenDescription =
      "/api/v1/market-data/coin-details?symbol=";
}

@RestApi()
abstract class TokenDescriptionRepository {
  factory TokenDescriptionRepository(Dio dio, {String baseUrl}) =
      _TokenDescriptionRepository;

  @GET("${TokenDescriptionApi.tokenDescription}{name}")
  Future<ServerResponse?> fetchTokenDescription(@Path("name") String name);
}
