import 'package:ether_dart/ether_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/service/local_storage_service.dart';
import 'package:sportRex/core/util/appUtil/app_strings.dart';

class PerfomTransactionController extends StateNotifier<bool> {
  PerfomTransactionController(this.etherDart) : super(false);

  final LocalStorageServiceImpls _storage = LocalStorageServiceImpls();

  ///Inject Ether dart from locator
  EtherDart etherDart;

  ///Get provider from etherDart
  ///You can use this accross all app
  Web3Client? get _provider => etherDart.provider;


  ///Retrieve wallet address from the local storage
  Future<String?> get address async =>
      await _storage.retrieveEncyptedData(AppString.walletAddressKey);


  ///Retrive the user private key from the Encrypted local storage
  Future<String?> get _privateKey async =>
      await _storage.retrieveEncyptedData(AppString.privateKey);


  ///convert yout [TOKEN] to [WEI]
  BigInt ethToWei(String eth, {int decimals = 18}) =>
      BigInt.from((double.parse(eth) * pow(10, decimals)).toInt());

  ///Send token on the same network
  Future<bool> sendToken(
      {required String hexAddress,
      required String amount,
      required int decimal,
      required String contractAddress}) async {
    try {
      _busy();



      var privateKey = await _privateKey;

      if (_provider == null || privateKey == null) {
        $toastService.showError("Please import wallet again");
        _reset();
        return false;
      }

      String abi = await rootBundle.loadString('assets/json/abi.json');

      final chainId = await _provider!.getChainId();

      final deployContract = DeployedContract(
          ContractAbi.fromJson(abi, "transfer"),
          EthereumAddress.fromHex(contractAddress));



      final hash = await _provider!.sendTransaction(
          EthPrivateKey.fromHex(privateKey),
          Transaction.callContract(
              contract: deployContract,
              function: deployContract.function('transfer'),
              parameters: [
                EthereumAddress.fromHex(hexAddress),
                ethToWei(amount, decimals: decimal)
              ]),
          chainId: chainId.toInt());

      debugPrint("send hash $hash");

      _reset();

      return true;
    } catch (error) {
      $toastService.showError(e.toString());

      debugPrint("::::: Send coin error  $e ::::::");
      _reset();
      return false;
    }
  }


  ///Send coin on the same network [ETH-ETH]
  Future<bool> sendCoin(String hexAddress, String amountInEth) async {
    try {
      _busy();

      var privateKey = await _privateKey;

      if (_provider == null || privateKey == null) {
        $toastService.showError("Please import wallet again");
        return false;
      }

      final chainId = await _provider!.getChainId();

      final currentGasPrice = await _provider!.getGasPrice();

      await _provider!.sendTransaction(
          EthPrivateKey.fromHex(privateKey),
          Transaction(
            gasPrice: currentGasPrice,
            to: EthereumAddress.fromHex(hexAddress.toString().trim()),
            value: EtherAmount.inWei(ethToWei(
              amountInEth,
            )),
          ),
          chainId: chainId.toInt());

      _reset();

      return true;
    } catch (error) {
      $toastService.showError(e.toString());

      debugPrint("::::: Send coin error  $e ::::::");
      _reset();
      return false;
    }
  }


  ///Send NFT on the same network [ETH-ETH]
  Future<bool> sendNFT(
    String hexAddress,
  ) async {
    try {
      _busy();

      var privateKey = await _privateKey;

      if (_provider == null || privateKey == null) {
        $toastService.showError("Please import wallet again");
        return false;
      }     

      final chainId = await _provider!.getChainId();

      final currentGasPrice = await _provider!.getGasPrice();

      await _provider!.sendTransaction(
          EthPrivateKey.fromHex(privateKey),
          Transaction(
            gasPrice: currentGasPrice,
            to: EthereumAddress.fromHex(hexAddress.toString().trim()),
            // value: EtherAmount.inWei(ethToWei(
            //   amountInEth,
            // )),
          ),
          chainId: chainId.toInt());
      // print(trans);
      _reset();

      return true;
    } catch (error) {
      $toastService.showError(e.toString());

      debugPrint("::::: Send NFT error  $e ::::::");
      _reset();
      return false;
    }
  }



  _busy() {
    state = true;
  }

  _reset() {
    state = false;
  }


}

final performTransactionController =
    StateNotifierProvider<PerfomTransactionController, bool>(
        (ref) => PerfomTransactionController(locator.get<EtherDart>()));
