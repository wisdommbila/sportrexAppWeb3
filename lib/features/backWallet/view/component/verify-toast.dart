import '../../../../core/commonLibs/common_libs.dart';
import '../../../../shared/app_icons.dart';

class VerifyToast extends StatelessWidget {
  const VerifyToast(
      {Key? key,
      required this.icon,
      required this.text,
      required this.backgroundColor})
      : super(key: key);

  final AppIcons? icon;
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(
                icon!,
                size: 28,
              ),
              Gap(10 * $styles.scale),
              Text(
                text,
                style: $styles.text.body.copyWith(
                    color: $styles.colors.tertiary,
                    fontSize: 14.8.sp,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }
}
