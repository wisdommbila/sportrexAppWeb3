import 'package:dio/dio.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/exception/app_exceptions.dart';
import 'package:sportRex/core/util/appUtil/logger.dart';
import 'package:sportRex/features/backWallet/model/data/backup_wallet_datasource.dart';
import 'package:sportRex/features/backWallet/model/data/verify_seedPhrase_request.dart';
import 'package:sportRex/features/backWallet/model/data_source/network/backup_wallet_repository.dart';

class BackUpWalletNetworkService
    extends BackUpWalletDataSource<ServerResponse> {
  final log = getLogger(BackUpWalletNetworkService);
  final BackUpWalletRepository _backupWalletRepository;

  BackUpWalletNetworkService(this._backupWalletRepository);

  @override
  Future<ServerResponse?> createAccount() async {
    try {
      log.i("  ::::====> createAccount ::::::");
      return await _backupWalletRepository.createAccount();
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }

  @override
  Future<ServerResponse?> verifySeedPhrase(
      VerifySeedPhraseRequest verifySeedPhraseRequest) async {
    try {
      log.i("  ::::====> verifySeedPhrase ::::::");
      return await _backupWalletRepository
          .verifySeedPharse(verifySeedPhraseRequest);
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }
}
