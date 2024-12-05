import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/features/home/model/data/tab_state.dart';
import 'package:sportRex/features/home/view/ui_state/home_ui_state.dart';

class HomeController extends StateNotifier<HomeUiState> {

  HomeController() : super(const HomeUiState(isBusy: false));

  changeTabState(int postition) => switch (postition) {
        0 => state = state.copy(tabState: TabState.token),
        1 => state = state.copy(tabState: TabState.nft),
        _ => state = state.copy(tabState: TabState.token)
      };

}

final homeController =
    StateNotifierProvider<HomeController, HomeUiState>((ref) {
  return HomeController();
});
