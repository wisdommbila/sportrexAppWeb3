import 'package:sportRex/core/commonLibs/common_libs.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(AppAssets.empty),
        const Gap(5),
        Text(
          "There is nothing here",
          style: $styles.text.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              color: $styles.colors.white,
              fontSize: 18.sp),
          textAlign: TextAlign.center,
        ),
        Text(
          "Tap to try again ",
          style: $styles.text.bodySmall.copyWith(
              fontWeight: FontWeight.w300,
              color: $styles.colors.white,
              fontSize: 14.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
