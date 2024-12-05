import 'package:dio/dio.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/exception/app_exceptions.dart';
import 'package:sportRex/core/util/appUtil/logger.dart';
import 'package:sportRex/features/addWallet/model/data/add_wallet_datasource.dart';
import 'package:sportRex/features/addWallet/model/data/import_keypharse_request.dart';
import 'package:sportRex/features/addWallet/model/data_source/network/add_wallet_repository.dart';

class ImportWalletSerive implements ImportWalletDataSource<ServerResponse> {
  final log = getLogger(ImportWalletSerive);

  final AddWalletRepository _addWalletRepository;
  ImportWalletSerive(this._addWalletRepository);

  @override
  Future<ServerResponse?> importWithAddress() {
    throw UnimplementedError();
  }

  @override
  Future<ServerResponse?> importWithPrivateKey(String privateKey) async {
    try {
      log.i("  ::::====> import With Private Key ::::::");
      return await _addWalletRepository.importWPrivateKey(privateKey);
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }

  @override
  Future<ServerResponse?> importWkeyPharse(
      ImportKeyPharseRequest importKeyPharseRequest) async {
    try {
      log.i("  ::::====> import With key Pharse ::::::");
      return await _addWalletRepository
          .importWkeyPharse(importKeyPharseRequest);
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }


}
