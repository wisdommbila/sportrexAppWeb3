import 'package:sportRex/core/commonLibs/common_libs.dart';

class EmptySearch extends StatelessWidget {
  const EmptySearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.5.sh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.robot,
            width: 60,
            height: 100,
          ),
          Gap(20 * $styles.scale),
          Text($strings.nothingThere,
              style: $styles.text.bodySmall.copyWith(
                  fontWeight: FontWeight.w400,
                  color: $styles.colors.white,
                  fontSize: 14.sp)),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}
