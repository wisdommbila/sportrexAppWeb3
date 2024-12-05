

import 'package:sportRex/features/backWallet/model/data/verify_seedPhrase_request.dart';

abstract class  BackUpWalletDataSource<T>{

   /// Creates the given data into this data source, replacing it if
  /// it exists already. It throws an [Exception] in case of any error
  Future<T?> createAccount();
  Future<T?> verifySeedPhrase(VerifySeedPhraseRequest verifySeedPhraseRequest);

}