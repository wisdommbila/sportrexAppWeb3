import 'dart:async';
import 'dart:convert';

import 'package:ether_dart/ether_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/server_error_catch.dart';
import 'package:sportRex/core/exception/app_exceptions.dart';
import 'package:sportRex/core/service/local_storage_service.dart';
import 'package:sportRex/core/service/toast_service.dart';
import 'package:sportRex/core/util/appUtil/app_strings.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/features/addWallet/model/data/add_wallet_datasource.dart';
import 'package:sportRex/features/addWallet/model/data/import_keypharse_request.dart';
import 'package:sportRex/features/addWallet/model/data/wallet_model.dart';
import 'package:sportRex/features/addWallet/model/data_source/network/add_wallet_service.dart';
import 'package:sportRex/features/addWallet/view/page/ui_state/import_wallet_ui_state.dart';

class ImportWalletController extends StateNotifier<ImportWalletUiState>
    with CheckForServerError {
  ImportWalletController({required this.importWalletDataSource})
      : super(const ImportWalletUiState(isBusy: false));

  final ImportWalletDataSource importWalletDataSource;

  final LocalStorageServiceImpls _storage = LocalStorageServiceImpls();

  Future<bool> importWkeyPharse(ImportKeyPharseRequest keyPharseRequest) async {
    try {
      _isBusy(true);

      if (isEmpty(keyPharseRequest.seedPhrase)) return false;

      final proceed = locator
          .get<EtherDart>()
          .verifyMemonicPhrase(keyPharseRequest.seedPhrase!);

      if (!proceed) {
        $toastService.showError("Could not verify seed phrase");
        reset();
        return false;
      }

      final wallet = locator
          .get<EtherDart>()
          .walletFromMemonicPhrase(keyPharseRequest.seedPhrase!);

      if (isObjectEmpty(wallet)) {
        locator
            .get<ToastService>()
            .showError("Please check your key and try again");
        reset();
        return false;
      }

      // await saveSeedPhraseAndPrivateKey(
      //     seedPhrase: wallet?.mnemonic?.phrase,
      //     privateKey: wallet?.privateKey,
      //     address: wallet?.address);

      await saveWallet(WalletModel(
          walletAddress: wallet?.address,
          seedPhrase: wallet?.mnemonic?.phrase,
          privateKey: wallet?.privateKey,
          status: true));
      reset();

      locator.get<ToastService>().showSuccess("Wallet Verified Successful");

      return true;
    } on AppException catch (error) {
      locator.get<ToastService>().showError(error.toString());
      reset();
      return false;
    }
  }

  Future<bool> importWalletWithAddress(String address) async {
    await saveWallet(WalletModel(walletAddress: address, status: true));
    return true;
  }

  Future<bool> importWWalletFromKeyStore(String json, String password) async {
    try {
      _isBusy(true);

      final wallet =
          locator.get<EtherDart>().walletFromKeystore(json, password);

      if (isObjectEmpty(wallet)) {
        locator
            .get<ToastService>()
            .showError("Please check your key and try again");
        reset();
        return false;
      }

      await saveWallet(WalletModel(
          walletAddress: wallet?.address,
          seedPhrase: wallet?.mnemonic?.phrase,
          privateKey: wallet?.privateKey,
          status: true));

      reset();

      locator.get<ToastService>().showSuccess("Wallet Imported Successful");

      return true;
    } on AppException catch (error) {
      locator.get<ToastService>().showError(error.toString());
      reset();
      return false;
    }
  }

  Future<bool> importWithPrivateKey(String privateKey) async {
    try {
      _isBusy(true);

      final wallet = locator.get<EtherDart>().walletFromPrivateKey(privateKey);

      if (isObjectEmpty(wallet)) {
        locator
            .get<ToastService>()
            .showError("Please check your key and try again");
        reset();
        return false;
      }

      await saveWallet(WalletModel(
          walletAddress: wallet?.address,
          seedPhrase: wallet?.mnemonic?.phrase,
          privateKey: wallet?.privateKey,
          status: true));
      reset();

      locator.get<ToastService>().showSuccess("Wallet Imported Successful");

      return true;
    } on AppException catch (error) {
      locator.get<ToastService>().showError(error.toString());
      reset();
      return false;
    }
  }

  saveSeedPhraseAndPrivateKey(
      {String? seedPhrase,
      String? privateKey,
      String? address,
      String? chainId}) async {

        
    await _storage.saveEncyptedData(AppString.seedPhrasekey, seedPhrase ?? '');
    await _storage.saveEncyptedData(AppString.walletAddressKey, address ?? '');
    await _storage.saveEncyptedData(AppString.privateKey, privateKey ?? '');
    await _storage.saveEncyptedData(AppString.chainIdKey, chainId ?? '');

    
  }

  saveWallet(WalletModel data) async {
    _isBusy(true);
    List<WalletModel> savedWallets = [];
    final wallets = await _storage.retrieveEncyptedData(AppString.walletKey);

    if (wallets != null) {
      json.decode(wallets).forEach((v) {
        savedWallets.add(WalletModel.fromJson(v));
      });

      savedWallets = savedWallets.map((e) => e..status = false).toList();

      savedWallets.insert(
          0,
              isEmpty(data.walletName)
              ? data.copy(walletName: 'Wallet ${savedWallets.length + 1}')
              : data);
    } else {
      savedWallets.add(data..walletName = "Wallet 1");
    }


    final jsonList =
        savedWallets.map((json) => jsonEncode(json.toJson())).toList();

    _storage.saveEncyptedData(AppString.walletKey, jsonList.toString());

    saveSeedPhraseAndPrivateKey(
      seedPhrase: savedWallets[0].seedPhrase,
      privateKey: savedWallets[0].privateKey,
      address: savedWallets[0].walletAddress,
      chainId: savedWallets[0].chainID
    );

    reset();
  }


  updateWallet(List<WalletModel> data) async {
    _isBusy(true);

    final jsonList = data.map((json) => jsonEncode(json.toJson())).toList();

    _storage.saveEncyptedData(AppString.walletKey, jsonList.toString());

    reset();
  }

  reset() {
    _isBusy(false);
  }

  _isBusy(bool loading) {
    state = state.copy(isBusy: loading);
  }

  // saveWallet(WalletModel data) async {
  //   _isBusy(true);
  //   List<WalletModel> savedWallets = [];
  //   final wallets = await _storage.retrieveEncyptedData(AppString.walletKey);

  //   if (wallets != null) {
  //     json.decode(wallets).forEach((v) {
  //       savedWallets.add(WalletModel.fromJson(v));
  //     });

  //     savedWallets = savedWallets.map((e) => e..status = false).toList();

  //     savedWallets.insert(
  //         0,
  //         data.walletName != null || data.walletName!.isNotEmpty
  //             ? data.copy(walletName: 'Wallet${savedWallets.length + 1}')
  //             : data);
  //   } else {
  //     savedWallets.add(data..walletName = "Wallet1");
  //   }

  //   final jsonList =
  //   savedWallets.map((json) => jsonEncode(json.toJson())).toList();

  //   _storage.saveEncyptedData(AppString.walletKey, jsonList.toString());

  //   saveSeedPhraseAndPrivateKey(
  //     seedPhrase: savedWallets[0].seedPhrase,
  //     privateKey: savedWallets[0].privateKey,
  //     address: savedWallets[0].walletAddress,
  //   );

  //   reset();
  // }

  // updateWallet(List<WalletModel> data) async {
  //   _isBusy(true);

  //   final jsonList = data.map((json) => jsonEncode(json.toJson())).toList();

  //   _storage.saveEncyptedData(AppString.walletKey, jsonList.toString());

  //   reset();
  // }
}

///for ui and state update calls
final importWalletController =
    StateNotifierProvider<ImportWalletController, ImportWalletUiState>((ref) {
  return ImportWalletController(
      importWalletDataSource: locator.get<ImportWalletSerive>());
});
