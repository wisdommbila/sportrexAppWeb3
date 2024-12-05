import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/data/typdef.dart';
import 'package:sportRex/core/exception/app_exceptions.dart';
import 'package:sportRex/core/service/toast_service.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/core/util/debouncer.dart';
import 'package:sportRex/features/dex/model/data_source/network/dex_service.dart';
import 'package:sportRex/features/dex/model/dex_data_source.dart';
import 'package:sportRex/features/dex/model/token_swap.dart';
import 'package:sportRex/features/dex/view/ui_state/swap_list_ui_state.dart';

class SwapListController extends StateNotifier<SwapListUiState> {
  SwapListController(this._dexDataSource) : super(const SwapListUiState()) {
    ///Network if from the current network you are in
    setNetworkId(1);
    getSwapToken();
  }

  //TODO:(author:precious) please find a better way
  final searchController = TextEditingController();

  ///Added comment
  final searchDebouncer =
      DebouncerService(interval: const Duration(milliseconds: 300));

  int get _getNetworkId => networkId;

  late int networkId;

  void setNetworkId(id) => networkId = id;

  final DexDataSource _dexDataSource;

  Future<void> getSwapToken() async {
    try {
      _isBusy(true);

      final response =
          await _dexDataSource.getSwapToken(_getNetworkId) as ServerResponse;

      if (isObjectEmpty(response.payload)) {
        locator.get<ToastService>().showError("Error occurred please refresh");
        return;
      }

      final tokens = TokensSwap.fromJson(response.payload as DynamicMap);

      _updateSwapTokenList(swapTokens: tokens.tokenList);

      return;
    } on AppException catch (error) {
      locator.get<ToastService>().showError(error.toString());

      return;
    } finally {
      reset();
    }
  }

  void search(String searchItem) {
    searchDebouncer.call(() {
      final searchResult = filterList(searchItem);
      _updateSwapTokenList(swapTokens: searchResult, updateFallBack: false);
    }, false);
  }

  ///Current Search Algorithm
  ///please change later
  List<SwapTokens> filterList(String query) {
    final items = state.fallbackList.toList();
    if (query.isNotEmpty) {
      final filterItems = items.where((element) {
        if (isEmpty(element.symbol)) return false;
        return element.symbol!.toLowerCase().contains(query.toLowerCase());
      }).toList();

      return filterItems;
    } else {
      return state.fallbackList.toList();
    }
  }

  _updateSwapTokenList(
      {required List<SwapTokens> swapTokens, bool updateFallBack = true}) {
    state = state.copy(
        swapTokens: swapTokens,
        fallbackSearchToken: updateFallBack ? swapTokens : null);
  }

  _isBusy(bool value) {
    state = state.copy(isBusy: value);
  }

  reset() {
    _isBusy(false);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

final swapListController =
    StateNotifierProvider<SwapListController, SwapListUiState>(
        (ref) => SwapListController(locator.get<DexService>()));
