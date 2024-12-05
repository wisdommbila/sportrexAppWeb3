import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/features/token/model/data/chain_list_response.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/bottom_sheet_skeleton.dart';

class SelectNetwork extends StatelessWidget {
  const SelectNetwork({
    Key? key,
    required this.onSubmit,
    required this.networks,
  }) : super(key: key);

  final Function(NetworkData) onSubmit;
  final ChainListResponse networks;

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
          ListView.builder(
              itemCount: networks.data?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return AppBtn.basic(
                  onPressed: () {
                    onSubmit.call(networks.data![index]);
                  },
                  semanticLabel: '',
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0XFF0E1648),
                        border: Border.all(
                            color: $styles.colors.secondary, width: 0.5)),
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
                            Text(networks.data![index].name!,
                                style: $styles.text.title2.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: $styles.colors.white,
                                    fontSize: 14.sp)),
                          ],
                        ),
                        // const AppIcon(AppIcons.checkbox),
                      ],
                    ),
                  ),
                );
              }),
          Gap(50 * $styles.scale),
        ],
      ),
    );
  }
}
