import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';

class BottomSheetSkeleton extends StatelessWidget {
  final Widget child;

  const BottomSheetSkeleton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        closKeyPad(context);
      },
      child: Container(
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF002B81),
                Color(0xFF011846),
              ],
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  spreadRadius: pageHeight(context),
                  blurRadius: 1)
            ],
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(30))),
        child: Padding(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: child,
        ),
      ),
    );
  }
}
