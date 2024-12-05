import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/service/base_change_notifier.dart';

class SecureWalletController extends BaseChangeNotifier {
  bool isBtnActive = false;

  onBtnActiveChange(String val) {
    if (val.isNotEmpty) {
      isBtnActive = true;
    } else {
      isBtnActive = false;
    }
    setState();
  }
}

final secureWalletProvider =
    ChangeNotifierProvider((ref) => SecureWalletController());
