import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/bottom_sheet_skeleton.dart';

class SelectProvider extends StatelessWidget {
  const SelectProvider({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return BottomSheetSkeleton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(20 * $styles.scale),
          Container(
            width: 80.w,
            height: 5.h,
            decoration: BoxDecoration(
                color: $styles.colors.primary.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10)),
          ),
          Gap(40 * $styles.scale),
          AppBtn.basic(
            onPressed: () {
              onSubmit.call();
            },
            semanticLabel: '',
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    $styles.colors.primary400,
                    $styles.colors.secondary,
                  ], stops: const [
                    0.0,
                    2.5
                  ]),
                  border:
                      Border.all(color: $styles.colors.secondary, width: 0.5)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppIcon(
                        AppIcons.binance,
                        size: 24,
                      ),
                      const Gap(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Transak",
                              style: $styles.text.title2.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: $styles.colors.white,
                                  fontSize: 14.sp)),
                          const Gap(6),
                          Text($strings.thirdPartyProvider,
                              style: $styles.text.title2.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: $styles.colors.greyMedium,
                                  fontSize: 12.sp))
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("0.0",
                          style: $styles.text.title2.copyWith(
                              fontWeight: FontWeight.w400,
                              color: $styles.colors.white,
                              fontSize: 14.sp)),
                      const Gap(6),
                      Text("Best Rate",
                          style: $styles.text.title2.copyWith(
                              fontWeight: FontWeight.w600,
                              color: $styles.colors.white,
                              fontSize: 12.sp))
                    ],
                  ),
                ],
              ),
            ),
          ),
          Gap(50 * $styles.scale),
        ],
      ),
    );
  }
}
