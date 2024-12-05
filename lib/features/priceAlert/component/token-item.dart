import '../../../core/commonLibs/common_libs.dart';
import '../../../shared/app_icons.dart';

class TokenAlertItem extends StatelessWidget {
  const TokenAlertItem({Key? key, this.title, this.image}) : super(key: key);

  final image;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: $styles.colors.primary400,
        border: Border.symmetric(
            horizontal:
            BorderSide(color: $styles.colors.primaryBorder, width: 0.5)),
      ),
      child: Row(
        children: [
           AppIcon(
            image!,
             isSvg: false,
            size: 40,
          ),
          Gap(20 * $styles.scale),
          Text(
            title!,
            style: $styles.text.body.copyWith(
                color: $styles.colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
