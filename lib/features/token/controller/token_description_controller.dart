import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/config/dependecies.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/exception/app_exceptions.dart';
import 'package:sportRex/core/service/toast_service.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/features/token/model/data/token_data_source.dart';
import 'package:sportRex/features/token/model/data/token_description_response.dart';
import 'package:sportRex/features/token/model/dataSource/token_service.dart';
import 'package:sportRex/features/token/view/ui_state/token_description_ui_state.dart';

class TokenDescriptionController
    extends StateNotifier<TokenDescriptionUiState> {
  TokenDescriptionController({required this.networkDataSource})
      : super(const TokenDescriptionUiState(isBusy: false)) {
    _isBusy(true);
  }

  final TokenDataSource networkDataSource;

  TokenDescriptionResponse? _tokenDescriptionResponse;
  TokenDescriptionResponse? get tokenDescriptionResponse =>
      _tokenDescriptionResponse;

  ServerResponse? serverResponse;
  bool status = false;

  onSwitchChanged() {
    status = !status;
    reset();
  }

  Future<bool> fetchTokenDescription(String name) async {
    try {
      // _isBusy(true);

      serverResponse = await networkDataSource.fetchDescription(name);

      if (isObjectEmpty(serverResponse)) {
        reset();
        locator.get<ToastService>().showError("Please Try Again");
        return false;
      }

      if (!(serverResponse!.isSuccess!)) {
        reset();
        locator.get<ToastService>().showError(
            serverResponse?.defaultMessage ?? serverResponse!.errorMessage!);
        return false;
      }

      if ((serverResponse!.isSuccess!)) {
        _tokenDescriptionResponse = TokenDescriptionResponse.fromJson(
            serverResponse!.payload! as Map<String, dynamic>);
        reset();
        return true;
      }

      reset();

      return true;
    } on AppException catch (error) {
      locator.get<ToastService>().showError(error.toString());
      reset();
      return false;
    } finally {
      reset();
    }
  }

  reset() {
    _isBusy(false);
  }

  _isBusy(bool loading) {
    state = state.copy(isBusy: loading);
  }
}

///for ui and state update calls
final tokenDescriptionController = StateNotifierProvider.autoDispose<
    TokenDescriptionController, TokenDescriptionUiState>((ref) {
  return TokenDescriptionController(
      networkDataSource: locator.get<TokenNetworkService>());
});
