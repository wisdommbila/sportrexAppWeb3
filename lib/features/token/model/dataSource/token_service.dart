import 'package:dio/dio.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/exception/app_exceptions.dart';
import 'package:sportRex/core/util/appUtil/logger.dart';
import 'package:sportRex/features/token/model/data/token_data_source.dart';
import 'package:sportRex/features/token/model/dataSource/token_description_repository.dart';
import 'package:sportRex/features/token/model/dataSource/token_prices_history_repository.dart';
import 'package:sportRex/features/token/model/dataSource/token_repository.dart';
import 'package:sportRex/features/token/model/dataSource/wallet_transactions_repository.dart';

class TokenNetworkService extends TokenDataSource<ServerResponse> {
  final log = getLogger(TokenNetworkService);
  final TokenRepository _tokenRepository;
  final TokenPricesHistoryRepository _pricesHistoryRepository;

  final TokenDescriptionRepository _tokenDescriptionRepository;
  final WalletTransactionsRepository _walletTransactionsRepository;

  TokenNetworkService(this._tokenRepository, this._tokenDescriptionRepository,
      this._walletTransactionsRepository, this._pricesHistoryRepository);

  @override
  Future<ServerResponse?> fetchTokenDetails(
      String address, Map<String, dynamic> body) async {
    try {
      log.i("  ::::====> fetchTokenDetails bodyyyyyyyyy ::::::");

      log.i(body.toString());
      return await _tokenRepository.fetchTokenDetails(address, body);
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }

  @override
  Future<ServerResponse?> fetchTokenPriceHistory(
      String address, String chainId) async {
    try {
      log.i("  ::::====> fetchTokenPriceHistory ::::::");
      return await _pricesHistoryRepository.fetchTokenPriceHistory(
          address, chainId);
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }

  @override
  Future<ServerResponse?> fetchNetworks(String address) async {
    try {
      log.i("  ::::====> fetchNetworks ::::::");
      return await _tokenRepository.fetchNetworks(address);
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }

  @override
  Future<ServerResponse?> fetchNetworkTokens(String tokenName) async {
    try {
      log.i("  ::::====> fetchNetworkTokens ::::::");
      return await _tokenRepository.fetchNetworkTokens(tokenName);
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }

  @override
  Future<ServerResponse?> fetchChainList(String address) async {
    try {
      log.i("  ::::====> fetchNetworks ::::::");
      return await _tokenRepository.fetchNetworks(address);
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }

  @override
  Future<ServerResponse?> importNetworkTokens(
      String chainId, String contractAddress) async {
    try {
      log.i("  ::::====> importNetworksTokens ::::::");
      return await _tokenRepository.importNetworkTokens(
          contractAddress, chainId);
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }

  @override
  Future<ServerResponse?> fetchDescription(String name) async {
    try {
      log.i("  ::::====> fetchTokenDescription ::::::");
      return await _tokenDescriptionRepository.fetchTokenDescription(name);
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }

  @override
  Future<ServerResponse?> fetchWalletTransactions(
      String chainId, String address, String symbol) async {
    try {
      log.i("  ::::====> fetchWalletTransactions ::::::");
      return await _walletTransactionsRepository.fetchTokenDetails(
          chainId, address, symbol);
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }
}
