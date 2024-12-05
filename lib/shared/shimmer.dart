import 'package:shimmer/shimmer.dart';

import '../core/commonLibs/common_libs.dart';

class LoadingIndicator extends StatelessWidget {
  final int? itemLength;
  const LoadingIndicator({super.key, this.itemLength});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => Gap(10 * $styles.scale),
            padding: const EdgeInsets.all(10),
            itemCount: itemLength ?? 6,
            itemBuilder: (context, index) {
              return Container(
                height: 60,
                decoration: BoxDecoration(
                    color: $styles.colors.greyMedium.withOpacity(0.3)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: $styles.colors.greyMedium.withOpacity(0.5),
                      width: 70,
                      height: 60,
                    ),
                    const Gap(5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: $styles.colors.greyMedium.withOpacity(0.5),
                            height: 5,
                          ),
                          const Gap(10),
                          Container(
                            color: $styles.colors.greyMedium.withOpacity(0.5),
                            height: 5,
                          )
                        ],
                      ).paddingOnly(right: 50),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
