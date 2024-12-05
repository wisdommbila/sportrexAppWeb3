import 'package:flutter/foundation.dart';

@immutable
class LoginUiState {
  const LoginUiState({
    this.isBusy = false,
    this.errorMsg = '',
  });

  final bool isBusy;
  final String errorMsg;

  LoginUiState copy({
    bool? pinIsComplete,
    bool? isBusy,
    String? errorMsg,
  }) {
    return LoginUiState(
      isBusy: isBusy ?? this.isBusy,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
