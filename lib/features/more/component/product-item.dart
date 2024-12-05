import '../../../core/commonLibs/common_libs.dart';
import '../../../shared/app_icons.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: $styles.colors.primary400,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(
            AppIcons.logotext,
            size: $styles.scale.reactive(75)!,
          ),
          // Text($strings.otherApps,
          //     style: $styles.text.body.copyWith(
          //         color: $styles.colors.tertiary,
          //         fontSize: 5.sp,
          //         fontWeight: FontWeight.w300)),
        ],
      ).paddingAll(2),
    ).paddingAll(5);
  }
}
