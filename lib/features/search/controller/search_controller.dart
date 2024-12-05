import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/util/appUtil/logger.dart';
import 'package:sportRex/features/search/view/ui_state/search_uistate.dart';

final logger = getLogger(SearchController);

class SearchController extends StateNotifier<SearchUiState> {
  SearchController()
      : super(
            const SearchUiState(isBusy: false, searchType: SearchType.crypto));

  _reset() {
    _isBusy(false);
  }

  _isBusy(bool loading) {
    state = state.copy(isBusy: loading);
  }

  _onError(String error) {
    state = state.copy(errorMsg: error);
  }

  void setNftSearchType() {
    state = state.copy(searchType: SearchType.nft);
  }

  void performSearch(String? search) => switch (search) {
        "crypto" || "Btc" => state = state.copy(searchType: SearchType.crypto),
        "Nft" || "nft" => state = state.copy(searchType: SearchType.nft),
        _ => state = state.copy(searchType: SearchType.none)
      };
}

///for ui and state update calls
final searchController =
    StateNotifierProvider.autoDispose<SearchController, SearchUiState>((ref) {
  return SearchController();
});
