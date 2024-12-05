import '../commonLibs/common_libs.dart';

class ToastService {
  showSuccess(String message, {String? title = "Success"}) {
    Get.snackbar(title ?? "Success", message,
        backgroundColor: $styles.colors.green.withOpacity(.5),
        colorText: $styles.colors.white);
  }

  showError(String message, {String? title = "Error"}) {
    Get.snackbar(
      title ?? "Error!",
      message,
      colorText: $styles.colors.white,
      backgroundColor: $styles.colors.red.withOpacity(.5),
    );
  }

  showHint(String message, {String? title = "Hint"}) {
    Get.snackbar(
      title ?? "Hint",
      message,
      backgroundColor: $styles.colors.primary.withOpacity(.4),
    );
  }


}
