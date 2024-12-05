import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/config/dependecies.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/exception/app_exceptions.dart';
import 'package:sportRex/core/service/local_storage_service.dart';
import 'package:sportRex/core/service/toast_service.dart';
import 'package:sportRex/core/util/appUtil/app_strings.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/features/nft/model/data/nft_data_source.dart';
import 'package:sportRex/features/nft/model/data/nft_details_response.dart';
import 'package:sportRex/features/nft/model/datasource/nft_service.dart';
import 'package:sportRex/features/nft/view/ui_state/nft_details_uistate.dart';

class NFTDetailsController extends StateNotifier<NFTDetailsUiState> {
  NFTDetailsController({required this.networkDataSource})
      : super(const NFTDetailsUiState(isBusy: false)) {
    fetchNft();
  }

  final NFTDataSource networkDataSource;
  NftDetailsResponse? _nftDetailsResponse;
  NftDetailsResponse? get nftDetailsResponse => _nftDetailsResponse;
  ServerResponse? serverResponse;
  final LocalStorageServiceImpls _storage = LocalStorageServiceImpls();

  Future<bool> fetchNft() async {
    try {
      _isBusy(true);
      var walletAddress =
          await _storage.retrieveEncyptedData(AppString.walletAddressKey);
      var chainId = await _storage.retrieveEncyptedData(AppString.chainIdKey);

      if (isEmpty(walletAddress)) {
        reset();
        locator.get<ToastService>().showError("Unable to fetch wallet address");
        return false;
      }

      // if (isEmpty(chainId)) {
      //   reset();
      //   locator.get<ToastService>().showError("Unable to fetch chainId");
      //   return false;
      // }

      // serverResponse =
      //     await networkDataSource.fetchNFTDetails(walletAddress, chainId);

      serverResponse = await networkDataSource.fetchNFTDetails(
          "0x80053651DEd8bCB962b6fdA539D4772306DBd41C", "0xaa36a7");

      if (isObjectEmpty(serverResponse)) {
        reset();
        locator.get<ToastService>().showError("Please Try Again");
        return false;
      }

      if (!(serverResponse!.isSuccess!)) {
        reset();
        locator.get<ToastService>().showError(
            serverResponse?.defaultMessage ?? serverResponse!.errorMessage!);
        return false;
      }

      if ((serverResponse!.isSuccess!)) {
        _nftDetailsResponse = NftDetailsResponse.fromJson(
            serverResponse!.payload! as Map<String, dynamic>);
        reset();
        return true;
      }

      reset();

      return true;
    } on AppException catch (error) {
      locator.get<ToastService>().showError(error.toString());
      reset();
      return false;
    } finally {
      reset();
    }
  }

  reset() {
    _isBusy(false);
  }

  _isBusy(bool loading) {
    state = state.copy(isBusy: loading);
  }
}

///for ui and state update calls
final nftDetailsController =
    StateNotifierProvider<NFTDetailsController, NFTDetailsUiState>((ref) {
  return NFTDetailsController(
      networkDataSource: locator.get<NFTNetworkService>());
});
