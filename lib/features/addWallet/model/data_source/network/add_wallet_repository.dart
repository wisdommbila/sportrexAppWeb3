import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/features/addWallet/model/data/import_keypharse_request.dart';

part 'add_wallet_repository.g.dart';

class AddWalletApi {
  static const String importWkeystoreJSON = "/api/v1/wallet/key-store-file/evm";
  static const String importWkeyPharse = "/api/v1/verify-seed-phrase";
  static const String importWithPrivateKey = "/api/v1/wallet/{privateKey}/evm";
}

@RestApi()
abstract class AddWalletRepository {
  factory AddWalletRepository(Dio dio, {String baseUrl}) = _AddWalletRepository;


  @POST(AddWalletApi.importWkeyPharse)
  Future<ServerResponse?> importWkeyPharse(
      @Body()  ImportKeyPharseRequest importKeyPharseRequest);


  @GET(AddWalletApi.importWithPrivateKey)
  Future<ServerResponse?> importWPrivateKey(@Path('privateKey') String privateKey);


}
