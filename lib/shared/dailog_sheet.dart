import '../core/commonLibs/common_libs.dart';

Future<void> showSizeSheet(BuildContext context, Widget widget,
    {Color colors = Colors.white,
    bool dismissible = true,
    EdgeInsets? edgeInsets}) {
  return showModalBottomSheet<void>(
    isDismissible: dismissible,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    barrierColor: $styles.colors.black.withOpacity(0.9),
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        
          builder: (BuildContext context, StateSetter setModalState) {
        return SingleChildScrollView(
          child: Wrap(
            children: [
              Container(
                margin: edgeInsets ?? EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: $styles.colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r)),
                ),
                child: Center(
                  child: widget,
                ),
              ),
            ],
          ),
        );
      });
    },
  );
}
