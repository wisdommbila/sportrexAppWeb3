import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/service/local_storage_service.dart';
import 'package:sportRex/core/service/toast_service.dart';
import 'package:sportRex/core/util/appUtil/app_strings.dart';
import 'package:sportRex/features/secure/view/page/login_screen.dart';
import 'package:sportRex/features/security/view/page/confirm_password.dart';
import 'package:sportRex/features/security/view/page/enter_new_password.dart';

import '../../../core/service/base_change_notifier.dart';

class SecureWalletPinController extends BaseChangeNotifier {
  bool isBtnActive = false;

  final LocalStorageServiceImpls _storage = LocalStorageServiceImpls();
  String pin = "";
  String readPin = "";
  String newPin = "";
  onBtnActiveChange(String val) {
    if (val.length == 4) {
      isBtnActive = true;
    } else {
      isBtnActive = false;
    }
    setState();
  }

  savePasscode() async {
    await _storage.saveEncyptedData(AppString.passcodeKey, pin.toString());
    $navigate.clearAllTo(LoginScreen.route);
    isBtnActive = false;
    setState();
  }

  saveNewPasscode() async {
    if (pin == newPin) {
      unawaited(
          _storage.saveEncyptedData(AppString.passcodeKey, pin.toString()));
      $navigate.popUntil(3);

      isBtnActive = false;
      setState();
    } else {
      locator.get<ToastService>().showError(" Pins do not match.");
    }
  }

  readPasscode() async {
    var read = await _storage.retrieveEncyptedData(AppString.passcodeKey);

    print(read);
    readPin = "$read";

    setState();
  }

  compareOldPascode() async {
    await readPasscode();

    if (pin == readPin) {
      $navigate.to(EnterNewPassword.route);
    } else {
      locator.get<ToastService>().showError("Incorrect Old Passcode");
    }

    isBtnActive = false;
    setState();
  }

  navigateToConfirm() {
    isBtnActive = false;
    $navigate.to(ConfirmPassword.route);
    setState();
  }
}

final secureWalletPinProvider =
    ChangeNotifierProvider.autoDispose((ref) => SecureWalletPinController());
