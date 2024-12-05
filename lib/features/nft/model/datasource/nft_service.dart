import 'package:dio/dio.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/exception/app_exceptions.dart';
import 'package:sportRex/core/util/appUtil/logger.dart';
import 'package:sportRex/features/nft/model/data/nft_data_source.dart';
import 'package:sportRex/features/nft/model/datasource/nft_repository.dart';

class NFTNetworkService extends NFTDataSource<ServerResponse> {
  final log = getLogger(NFTNetworkService);
  final NFTRepository _nftRepository;

  NFTNetworkService(this._nftRepository);

  @override
  Future<ServerResponse?> fetchNFTDetails(
      String address, String chainId) async {
    try {
      log.i("  ::::====> fetchNFTDetails ::::::");
      var res = await _nftRepository.fetchNftDetails(address, chainId);
      print(res);
      return res;
    } on DioException catch (e) {
      log.i(" Error message ::::=====> ${e.message} ::::::");

      return AppException.handleError(e);
    }
  }
}
