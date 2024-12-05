import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:sportRex/core/data/serverRespond.dart';

part 'token_repository.g.dart';

class TokenApi {
  static const String tokenDetails =
      "/api/v1/wallet-token-test-balances?address=";

  static const String networks = "/api/v1/networks";

  static const String networkTokens = "/api/v1/network-tokens";

  static const String importNetworkTokens =
      "/api/v1/import-network-token?tokenAddress=&chainId=";

  static const String chainList = "/api/v1/networks?address=";
}

@RestApi()
abstract class TokenRepository {
  factory TokenRepository(Dio dio, {String baseUrl}) = _TokenRepository;

  @GET(TokenApi.networks)
  Future<ServerResponse?> fetchNetworks(@Query("address") String address);

  @GET("${TokenApi.chainList}{address}")
  Future<ServerResponse?> fetchChainList(@Path("address") String address);

  @GET(TokenApi.networkTokens)
  Future<ServerResponse?> fetchNetworkTokens(
      @Path("search") String tokenAddress);

  @GET("${TokenApi.importNetworkTokens}{tokenAddress}{chainId}")
  Future<ServerResponse?> importNetworkTokens(
      @Path("tokenAddress") String address, @Path("chainId") String chainId);

  @POST("${TokenApi.tokenDetails}{address}")
  Future<ServerResponse?> fetchTokenDetails(
      @Path("address") String address, @Body() Map<String, dynamic> body);
}
