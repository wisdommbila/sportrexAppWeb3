import 'package:flutter/foundation.dart';
import 'package:sportRex/features/home/model/data/tab_state.dart';

@immutable
class HomeUiState {
  const HomeUiState(
      {this.isBusy = false,
      this.errorMsg = '',
      this.tabState = TabState.token});

  final bool isBusy;
  final String errorMsg;
  final TabState tabState;

  HomeUiState copy(
      {bool? pinIsComplete,
      bool? isBusy,
      String? errorMsg,
      TabState? tabState}) {
    return HomeUiState(
        isBusy: isBusy ?? this.isBusy,
        errorMsg: errorMsg ?? this.errorMsg,
        tabState: tabState ?? this.tabState);
  }
}
