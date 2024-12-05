import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/config/constant.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/exception/app_exceptions.dart';
import 'package:sportRex/core/service/local_storage_service.dart';
import 'package:sportRex/core/service/toast_service.dart';
import 'package:sportRex/core/util/appUtil/app_strings.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';

import 'package:sportRex/features/token/model/data/chain_list_response.dart'
    as chainListRes;
import 'package:sportRex/features/token/model/data/import_network_tokens_response.dart';
import 'package:sportRex/features/token/model/data/networks_response.dart';
import 'package:sportRex/features/token/model/data/token_data_source.dart';
import 'package:sportRex/features/token/model/data/token_detail_response.dart';
import 'package:sportRex/features/token/model/dataSource/token_service.dart';
import 'package:sportRex/features/token/view/ui_state/token_ui_state.dart';

import '../../../core/commonLibs/common_libs.dart';
import '../model/data/ network_tokens_response.dart';

class TokenController extends StateNotifier<TokenUiState> {
  TokenController({required this.networkDataSource})
      : super(const TokenUiState(isBusy: false)) {
    fetchTokens();
    fetchChainList();
    // fetchNetworks();
    fetchNetworkTokens();
    getLocallySavedTokens();
  }

  final TokenDataSource networkDataSource;
  TokenDetailsResponse? _tokenDetailsResponse;

  TokenDetailsResponse? get tokenDetailsResponse => _tokenDetailsResponse;

  chainListRes.ChainListResponse? _chainListResponse;

  chainListRes.ChainListResponse? get chainListResponse => _chainListResponse;

  // NetworksResponse? _networksResponse;
  //
  // NetworksResponse? get networkResponse => _networksResponse;

  NetworkTokensResponse? _networksTokenResponse;

  NetworkTokensResponse? get networkTokenResponse => _networksTokenResponse;

  ImportNetworkTokensResponse? _importNetworkTokensResponse;

  ImportNetworkTokensResponse? get importNetworkTokensResponse =>
      _importNetworkTokensResponse;

  List<ImportedTokenData>? _locallySavedTokens;

  List<ImportedTokenData>? get locallySavedTokens => _locallySavedTokens;


  List<TokenItem>? _tokenList;

  List<TokenItem>? get tokenList => _tokenList;


  List<ImportedTokenData>? _combinedTokens;

  List<ImportedTokenData>? get combinedTokens => _combinedTokens;

  ServerResponse? serverResponse;

  final LocalStorageServiceImpls _storage = LocalStorageServiceImpls();

  bool visible = true;

  var nameController = TextEditingController();
  var symbolController = TextEditingController();
  var decimalController = TextEditingController();

  onVisibleChanged() {
    visible = !visible;
    reset();
  }

  double balance = 0.0;

  reset() {
    _isBusy(false);
  }

  _isBusy(bool loading) {
    state = state.copy(isBusy: loading);
  }

  Future<bool> fetchTokens() async {
    List<TokenItem> tokens = <TokenItem>[];
    try {
      _isBusy(true);

      if (!isObjectEmpty(chainListResponse)) {
        for (var element in chainListResponse!.data!) {
          tokens.add(TokenItem(
            chain: element.chain,
            tokenAddress: null,
            name: element.name,
            symbol: element.symbol,
            decimals: element.decimals,
            balance: element.balance,
            quote: element.quote,
            logo: element.logo,
          ));
        }
      }

      print("${chainListResponse?.data?.length} TEST");
      print("${tokens.length} TEST");

      var walletAddress =
          await _storage.retrieveEncyptedData(AppString.walletAddressKey);


      await getLocallySavedTokens();


      if (!isObjectEmpty(locallySavedTokens)) {
        print("${locallySavedTokens?.length} TESTING");
        List<Map<String, dynamic>> tokenAddresses = [];


        locallySavedTokens?.forEach((token) {
          tokenAddresses.add(
            {"contract_address": token.contractAddress, "chain": token.chain},
          );
        });


        serverResponse = await networkDataSource.fetchTokenDetails(
            walletAddress, {"tokenAddresses": tokenAddresses});

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
          _tokenDetailsResponse = TokenDetailsResponse.fromJson(
              serverResponse!.payload! as Map<String, dynamic>);

            for (var token in locallySavedTokens!) {
              if (tokenDetailsResponse!.data!.isNotEmpty) {
                for (var element in tokenDetailsResponse!.data!) {
                  if (token.symbol == element.symbol &&
                      token.name == element.name &&
                      token.contractAddress == element.tokenAddress) {
                    tokens.add(TokenItem(
                      chain: element.chain,
                      tokenAddress: element.tokenAddress,
                      name: element.name,
                      symbol: element.symbol,
                      decimals: element.decimals,
                      balance: element.balance,
                      quote: element.quote,
                      logo: element.logo,
                    ));
                    break;
                  } else {
                    tokens.add(TokenItem(
                      chain: token.chain,
                      tokenAddress: token.contractAddress,
                      name: token.name,
                      symbol: token.symbol,
                      decimals: token.decimals,
                      balance: "",
                      quote: null,
                      logo: token.logo,
                    ));
                    break;
                  }
                }
              }else{
                tokens.add(TokenItem(
                  chain: token.chain,
                  tokenAddress: token.contractAddress,
                  name: token.name,
                  symbol: token.symbol,
                  decimals: token.decimals,
                  balance: "",
                  quote: null,
                  logo: token.logo,
                ));
              }
          }
          print(tokens.length);



          // balance += await getBalanceInDollars(tokens);

          reset();
          return true;
        }
      } else {
        locator.get<ToastService>().showError("Kindly Import a token");
      }

      _tokenList = tokens;
      return true;
    } on AppException catch (error) {
      locator.get<ToastService>().showError(error.toString());

      return false;
    } finally {
      reset();
    }
  }



  Future<bool> fetchNetworkTokens({String? tokenName}) async {
    try {
      _isBusy(true);

      serverResponse =
          await networkDataSource.fetchNetworkTokens(tokenName ?? "");

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
        _networksTokenResponse = NetworkTokensResponse.fromJson(
            serverResponse!.payload! as Map<String, dynamic>);

        await getLocallySavedTokens();

        if (locallySavedTokens != null) {
          _combinedTokens = [
            ...?locallySavedTokens,
            ...?networkTokenResponse?.data
          ];
        } else {
          _combinedTokens = networkTokenResponse?.data;
        }

        reset();
        return true;
      }

      reset();

      return true;
    } on AppException catch (error) {
      locator.get<ToastService>().showError(error.toString());
      reset();
      return false;
    }
  }

  setSelectedNetwork(chainListRes.NetworkData model) {
    state = state.copy(selectedNetwork: model);
  }

  Future<bool> importToken(String chainId, String contractAddress) async {
    try {
      _isBusy(true);
      serverResponse =
          await networkDataSource.importNetworkTokens(chainId, contractAddress);

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
        _importNetworkTokensResponse = ImportNetworkTokensResponse.fromJson(
            serverResponse!.payload! as Map<String, dynamic>);

        nameController.text = importNetworkTokensResponse!.data!.name!;
        symbolController.text = importNetworkTokensResponse!.data!.symbol!;
        decimalController.text =
            importNetworkTokensResponse!.data!.decimals!.toString();

        reset();
        return true;
      }

      reset();

      return true;
    } on AppException catch (error) {
      locator.get<ToastService>().showError(error.toString());
      reset();
      return false;
    }
  }

  Future getLocallySavedTokens() async {
    List<ImportedTokenData> tokenList = <ImportedTokenData>[];
    final tokens = await _storage.retrieveEncyptedData(AppString.tokenKey);

    if (tokens != null) {
      json.decode(tokens).forEach((v) {
        tokenList.add(ImportedTokenData.fromJson(v));
      });
      _locallySavedTokens = tokenList;
    }
  }

  validateToken(ImportedTokenData? data, bool status) async {
    _isBusy(true);
    List<ImportedTokenData> tokenList = [];
    final tokens = await _storage.retrieveEncyptedData(AppString.tokenKey);

    if (tokens != null) {
      json.decode(tokens).forEach((v) {
        tokenList.add(ImportedTokenData.fromJson(v));
      });

      // tokenList.add(data!);

      int index = tokenList.indexWhere((e) =>
          e.name == data?.name && e.contractAddress == data?.contractAddress);

      tokenList.removeAt(index);

      tokenList.insert(index, data!.copy(isActive: status));

      print(tokenList[index].isActive);

      final jsonList =
          tokenList.map((json) => jsonEncode(json.toJson())).toList();

      _storage.saveEncyptedData(AppString.tokenKey, jsonList.toString());

      getLocallySavedTokens();

      await fetchNetworkTokens();

      await fetchTokens();
    }

    reset();
  }

  saveToken(ImportedTokenData? data) async {
    _isBusy(true);
    List<ImportedTokenData> tokenList = [];
    final tokens = await _storage.retrieveEncyptedData(AppString.tokenKey);

    if (tokens != null) {
      json.decode(tokens).forEach((v) {
        tokenList.add(ImportedTokenData.fromJson(v));
      });

      for (var e in tokenList) {
        if (e.name == data?.name &&
            e.contractAddress == data?.contractAddress) {
          int index = tokenList.indexOf(e);

          tokenList.removeAt(index);
          tokenList.insert(index, data!);
          break;
        }
      }

      if (!(tokenList.contains(data))) {
        tokenList.add(data!);
      }
    } else {
      tokenList.add(data!);
    }

    final jsonList =
        tokenList.map((json) => jsonEncode(json.toJson())).toList();

    _storage.saveEncyptedData(AppString.tokenKey, jsonList.toString());

    getLocallySavedTokens();
    await fetchNetworkTokens();
    await fetchTokens();

    reset();
  }

  Future<double> getBalanceInDollars(List<TokenItem> data) async {
    double currentBalance = 0.0;

    for (var i in data) {
      final convertToDollars = convertToDollar(
          amount: double.parse(i.balance ?? "0.0"),
          decimal: i.decimals ?? int.parse("0.0"),
          usdValue: i.quote!.quote!.usd!.price!);

      currentBalance += double.tryParse(convertToDollars) != null
          ? double.tryParse(convertToDollars)!
          : 0;
    }
    return currentBalance;
  }

  Future<bool> fetchChainList() async {
    try {
      _isBusy(true);

      var walletAddress =
          await _storage.retrieveEncyptedData(AppString.walletAddressKey);
      serverResponse = await networkDataSource.fetchChainList(walletAddress);

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
        _chainListResponse = chainListRes.ChainListResponse.fromJson(
            serverResponse!.payload! as Map<String, dynamic>);

        state = state.copy(
            selectedNetwork: _chainListResponse?.data!
                .firstWhere((e) => e.symbol?.toLowerCase() == "eth"));

        await fetchTokens();
        reset();
        return true;
      }

      reset();

      return true;
    } on AppException catch (error) {
      locator.get<ToastService>().showError(error.toString());
      reset();
      return false;
    }
  }
}

///for ui and state update calls
final tokenDetailsController =
    StateNotifierProvider.autoDispose<TokenController, TokenUiState>((ref) {
  return TokenController(networkDataSource: locator.get<TokenNetworkService>());
});
