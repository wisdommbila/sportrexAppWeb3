import '../../../../core/commonLibs/common_libs.dart';

@immutable
class SearchUiState {
  const SearchUiState(
      {this.isBusy = false,
      this.errorMsg = '',
      this.searchType});

  final bool isBusy;
  final String errorMsg;
  final SearchType? searchType;

  SearchUiState copy({
    bool? pinIsComplete,
    bool? isBusy,
    SearchType? searchType,
    String? errorMsg,
  }) {
    return SearchUiState(
        isBusy: isBusy ?? this.isBusy,
        errorMsg: errorMsg ?? this.errorMsg,
        searchType: searchType ?? this.searchType);
  }
}

enum SearchType { crypto, nft, none }
