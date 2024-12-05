import 'package:sportRex/core/config/dependecies.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/service/toast_service.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';

mixin CheckForServerError {
  bool proceed(ServerResponse? serverResponse,
      {String? errorMessage, String? otherMessage}) {
    if (isObjectEmpty(serverResponse)) {
      locator.get<ToastService>().showError(errorMessage ?? "Please Try Again");
      return false;
    }

    if (!(serverResponse!.isSuccess!)) {
      locator.get<ToastService>().showError(otherMessage ??
          serverResponse.defaultMessage ??
          serverResponse.errorMessage!);
      return false;
    }

    return true;
  }
}
