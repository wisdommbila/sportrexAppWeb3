import 'package:sportRex/features/addWallet/model/data/import_keypharse_request.dart';

abstract class ImportWalletDataSource<T> {
  Future<T?> importWkeyPharse(ImportKeyPharseRequest importKeyPharseRequest);
 
  Future<T?> importWithPrivateKey(String privateKey);
  Future<T?> importWithAddress();
}


