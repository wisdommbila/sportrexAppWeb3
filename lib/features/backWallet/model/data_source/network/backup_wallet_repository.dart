import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/features/backWallet/model/data/verify_seedPhrase_request.dart';

part 'backup_wallet_repository.g.dart';

class BackUpWalletApi {
  static const String createAccount = "/api/v1/initialize-seed-phrase";
  static const String verifySeedPhrase = "/api/v1/verify-seed-phrase";
}

@RestApi()
abstract class BackUpWalletRepository {
  factory BackUpWalletRepository(Dio dio, {String baseUrl}) =
      _BackUpWalletRepository;

  @GET(BackUpWalletApi.createAccount)
  Future<ServerResponse?> createAccount();

  @POST(BackUpWalletApi.verifySeedPhrase)
  Future<ServerResponse?> verifySeedPharse(
      @Body() VerifySeedPhraseRequest verifySeedPhraseRequest);
}
