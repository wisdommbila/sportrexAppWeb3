import 'dart:convert';

import 'package:ether_dart/ether_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/data/server_error_catch.dart';
import 'package:sportRex/core/exception/app_exceptions.dart';
import 'package:sportRex/core/service/toast_service.dart';
import 'package:sportRex/core/util/appUtil/app_strings.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/features/backWallet/model/data/backup_wallet_datasource.dart';
import 'package:sportRex/features/backWallet/model/data/create_wallet_reponse.dart';
import 'package:sportRex/features/backWallet/model/data/verify_seedPhrase_request.dart';
import 'package:sportRex/features/backWallet/model/data/verify_seedPhrase_response.dart';
import 'package:sportRex/features/backWallet/model/data_source/network/backup_wallet_service.dart';
import 'package:sportRex/features/backWallet/view/ui_state/backup_pharse_uistate.dart';

import '../../../core/service/local_storage_service.dart';
import '../../addWallet/model/data/wallet_model.dart';

class BackUpPhasreController extends StateNotifier<BackUpPhraseUiState>
    with CheckForServerError {
  BackUpPhasreController({required this.networkDataSource})
      : super(const BackUpPhraseUiState(isBusy: false));

  final log = getLogger(BackUpWalletNetworkService);

  final LocalStorageServiceImpls _storage = LocalStorageServiceImpls();

  final BackUpWalletDataSource networkDataSource;

  ServerResponse? serverResponse;

  CreateWalletResponse? _createWalletResponse;

  CreateWalletResponse? get createWalletResponse => _createWalletResponse;

  VerifySeedPhraseResponse? _verifySeedPhraseResponse;

  VerifySeedPhraseResponse? get verifySeedPhraseResponse =>
      _verifySeedPhraseResponse;

  List<String> _shuffledSeedPhrase = <String>[];

  List<String> get shuffledSeedPhrase => _shuffledSeedPhrase;

  List<String> _seedPhrase = <String>[];

  List<String> get seedPhrase => _seedPhrase;

  Future<bool> createAccount() async {
    try {
      _isBusy(true);

      final memonicPhrase = locator.get<EtherDart>().generateMemonicPhrase();

      if (isEmpty(memonicPhrase)) return false;

      _seedPhrase = memonicPhrase!.split(" ");

      _shuffledSeedPhrase = List.from(_seedPhrase)..shuffle();

      log.i("YOUR SEED PHRASE ::::====>  $memonicPhrase ::::::");

      locator.get<ToastService>().showSuccess("Wallet Created Successful");

      reset();

      return true;
    } on AppException catch (error) {
      locator.get<ToastService>().showError(error.toString());
      reset();
      return false;
    }
  }

  Future<bool> verifySeedPhrase(
      VerifySeedPhraseRequest verifySeedPhraseRequest) async {
    try {
      _isBusy(true);

      if (isEmpty(verifySeedPhraseRequest.seedPhrase)) return false;

      final proceed = locator
          .get<EtherDart>()
          .verifyMemonicPhrase(verifySeedPhraseRequest.seedPhrase!);

      if (!proceed) {
        $toastService.showError("Could not verify seed phrase");
        reset();
        return false;
      }
      final wallet = locator
          .get<EtherDart>()
          .walletFromMemonicPhrase(verifySeedPhraseRequest.seedPhrase!);

      await saveWallet(WalletModel(
          walletAddress: wallet!.address,
          walletName: "",
          seedPhrase: wallet.mnemonic?.phrase,
          privateKey: wallet.privateKey,
          chainID: wallet.hdNode?.chainCode ?? "",
          status: true));

      locator.get<ToastService>().showSuccess("Wallet Verified Successful");

      reset();

      return true;
    } on AppException catch (error) {
      locator.get<ToastService>().showError(error.toString());
      reset();
      return false;
    }
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
          data.walletName != null || data.walletName!.isNotEmpty
              ? data.copy(walletName: 'Wallet${savedWallets.length + 1}')
              : data);
    } else {
      savedWallets.add(data..walletName = "Wallet1");
    }

    final jsonList =
        savedWallets.map((json) => jsonEncode(json.toJson())).toList();

    _storage.saveEncyptedData(AppString.walletKey, jsonList.toString());

    saveSeedPhraseAndPrivateKey(
      seedPhrase: savedWallets[0].seedPhrase,
      privateKey: savedWallets[0].privateKey,
      chainId: savedWallets[0].chainID,
      address: savedWallets[0].walletAddress,
    );

    reset();
  }

  updateWallet(List<WalletModel> data) async {
    _isBusy(true);

    final jsonList = data.map((json) => jsonEncode(json.toJson())).toList();

    _storage.saveEncyptedData(AppString.walletKey, jsonList.toString());

    reset();
  }

  saveSeedPhraseAndPrivateKey(
      {String? seedPhrase,
      String? privateKey,
      String? address,
      String? chainId}) async {
    await _storage.saveEncyptedData(AppString.seedPhrasekey, seedPhrase!);
    await _storage.saveEncyptedData(AppString.walletAddressKey, address!);
    await _storage.saveEncyptedData(AppString.privateKey, privateKey!);
    await _storage.saveEncyptedData(AppString.chainIdKey, chainId!);
  }

  reset() {
    _isBusy(false);
  }

  _isBusy(bool loading) {
    state = state.copy(isBusy: loading);
  }
}

///for ui and state update calls
final backupPharseController =
    StateNotifierProvider<BackUpPhasreController, BackUpPhraseUiState>((ref) {
  return BackUpPhasreController(
      networkDataSource: locator.get<BackUpWalletNetworkService>());
});
