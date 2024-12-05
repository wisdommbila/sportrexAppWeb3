import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'other_button.dart';

class AuthBaseScreen extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String buttonTitle;
  final List<Widget> children;
  final VoidCallback? onSubmitBtnPressed;
  final bool showTopLine;
  final EdgeInsets bodyPadding;
  final bool showBackBtn;

  const AuthBaseScreen(
      {Key? key,
      required this.title,
      required this.buttonTitle,
      required this.children,
      this.showBackBtn = false,
      this.bodyPadding = EdgeInsets.zero,
      this.onSubmitBtnPressed,
      this.subTitle,
      this.showTopLine = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(10*$styles.scale),

          Padding(
            padding: bodyPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (showBackBtn)
                  BackBtn(
                    iconColor: $styles.colors.black,
                  ),
                if (showBackBtn) Gap(30 * $styles.scale),
                Text(
                  title ?? "",
                  style: $styles.text.bodyBold.copyWith(
                      fontWeight: FontWeight.bold,
                      color: $styles.colors.black,
                      fontSize: 25.sp),
                ),
                Gap($styles.insets.xxs),
                Text(
                  subTitle ?? "",
                  style: $styles.text.bodySmall.copyWith(
                      fontWeight: FontWeight.w400,
                      color: $styles.colors.greyMedium,
                      fontSize: 14.8.sp),
                ),
                ...children,
                Gap($styles.insets.xl),
                AppBtn.from(
                  expand: true,
                  onPressed: onSubmitBtnPressed,
                  text: buttonTitle,
                  borderRadius: 18,
                  textColor: $styles.colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
