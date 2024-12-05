import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:sportRex/core/data/serverRespond.dart';

part 'dex_repository.g.dart';

class DexRepoApi {
  static const String swapTokens = "/{chainId}/tokens";
  static const String getQuote = "/{chainId}/quote";
}

@RestApi()
abstract class DexRepoRepository {
  factory DexRepoRepository(Dio dio, {String baseUrl}) = _DexRepoRepository;

  @GET(DexRepoApi.swapTokens)
  Future<ServerResponse?> getSwapTokens(
      {@Path("chainId") required int chainId,
      @Header("Authorization") required String bearerToken});

  @GET(DexRepoApi.getQuote)
  Future<ServerResponse?> getQuote(@Path("chainId") int chainId,
      {@Query("src") required String source,
      @Query("dst") required String destination,
      @Query("amount") required int amount,
      @Query("includeGas") required bool includeGas,
      @Header("Authorization") required String bearerToken});
}
