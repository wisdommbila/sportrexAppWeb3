import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/exception/app_exceptions.dart';
import 'package:sportRex/features/dex/model/data_source/network/dex_repository.dart';
import 'package:sportRex/features/dex/model/dex_data_source.dart';

class DexService extends DexDataSource<ServerResponse> {
  final log = getLogger(DexService);
  final DexRepoRepository _dexRepoRepository;

  DexService(this._dexRepoRepository);

  @override
  Future<ServerResponse?> getSwapToken(int chainId) async {
    try {
      log.i("  ::::====> getSwapToken ::::::");

      return await _dexRepoRepository.getSwapTokens(
          chainId: chainId, bearerToken: dotenv.get('1INCH_KEY'));
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }

  @override
  Future<ServerResponse?> getQuote(int chainId,
      {required String source,
      required String destination,
      required int amount,
      bool includeGas = true}) async {
    try {
      log.i("  ::::====> getQuote ::::::");

      return await _dexRepoRepository.getQuote(chainId,
          bearerToken: dotenv.get('1INCH_KEY'),
          amount: amount,
          destination: destination,
          includeGas: true,
          source: source);
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }
}
