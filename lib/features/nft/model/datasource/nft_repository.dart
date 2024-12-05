import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:sportRex/core/data/serverRespond.dart';

part 'nft_repository.g.dart';

class NFTApi {
  static const String nftDetails = "/api/v1/wallet-evm-nfts-test?address=";
}

@RestApi()
abstract class NFTRepository {
  factory NFTRepository(Dio dio, {String baseUrl}) = _NFTRepository;

  @POST("${NFTApi.nftDetails}{address}&chainId={chainId}")
  Future<ServerResponse?> fetchNftDetails(
      @Path("address") String address, @Path("chainId") String chainId);
}
