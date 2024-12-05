
import 'package:local_auth/local_auth.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';

class FingerPrintService {
  final _auth = LocalAuthentication();

  Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException {
      return <BiometricType>[];
    }
  }

  Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();

    if (!isAvailable) {
      $toastService.showError("Biometric not available");
      return false;
    }

    try {
      return await _auth.authenticate(
          localizedReason: 'Proceed to your dashboard',
          options: const AuthenticationOptions(
              useErrorDialogs: false, stickyAuth: true));
    } on PlatformException {
      return false;
    }
  }
}
