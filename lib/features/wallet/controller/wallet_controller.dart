import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/features/addWallet/model/data/wallet_model.dart';
import 'package:sportRex/features/wallet/view/ui_state/wallet_ui_state.dart';

import '../../../core/service/local_storage_service.dart';
import '../../../core/util/appUtil/app_strings.dart';

class WalletController extends StateNotifier<WalletUiState> {
  WalletController() : super(const WalletUiState(isBusy: false)) {
    getLocallySavedWallets();
  }

  final LocalStorageServiceImpls _storage = LocalStorageServiceImpls();

  List<WalletModel>? _locallySavedWallets;

  List<WalletModel>? get locallySavedWallets => _locallySavedWallets;

  reset() {
    _isBusy(false);
  }

  _isBusy(bool loading) {
    state = state.copy(isBusy: loading);
  }

  Future getLocallySavedWallets() async {
    _isBusy(true);

    List<WalletModel> tokenList = <WalletModel>[];
    final tokens = await _storage.retrieveEncyptedData(AppString.walletKey);

    if (tokens != null) {
      json.decode(tokens).forEach((v) {
        tokenList.add(WalletModel.fromJson(v));
      });
      _locallySavedWallets = tokenList;
    }

    reset();
  }

  updateWalletStatus(List<WalletModel> data, int index) async {
    _isBusy(true);

    final list = data.map((e) => e..status = false).toList();

    final model = list.removeAt(index);

    list.insert(0, model.copy(status: true));

    final jsonList = list.map((json) => jsonEncode(json.toJson())).toList();

    reset();

    _storage.saveEncyptedData(AppString.walletKey, jsonList.toString());

    saveSeedPhraseAndPrivateKey(
      seedPhrase: model.seedPhrase,
      privateKey: model.privateKey,
      chainId: model.chainID,
      address: model.walletAddress,
    );

    await getLocallySavedWallets();
  }

  updateWalletName(List<WalletModel> data, int index, String name) async {
    _isBusy(true);

    final model = data.removeAt(index);

    data.insert(index, model.copy(walletName: name));

    final jsonList = data.map((json) => jsonEncode(json.toJson())).toList();

    _storage.saveEncyptedData(AppString.walletKey, jsonList.toString());

    await getLocallySavedWallets();
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
}

///for ui and state update calls
final walletController =
    StateNotifierProvider.autoDispose<WalletController, WalletUiState>((ref) {
  return WalletController();
});
