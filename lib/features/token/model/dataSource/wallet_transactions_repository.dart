import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:sportRex/core/data/serverRespond.dart';

part 'wallet_transactions_repository.g.dart';

class WalletTransactionsApi {
  static const String walletTransactions =
      "/api/v1/wallet-transactions?symbol=";
}

@RestApi()
abstract class WalletTransactionsRepository {
  factory WalletTransactionsRepository(Dio dio, {String baseUrl}) =
      _WalletTransactionsRepository;

  @GET(
      "${WalletTransactionsApi.walletTransactions}{symbol}&chainId={chainId}&address={address}&cursor=")
  Future<ServerResponse?> fetchTokenDetails(@Path("chainId") String chainId,
      @Path("address") String address, @Path("symbol") String symbol);
}
