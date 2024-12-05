import 'package:sportRex/features/more/component/more-appbar.dart';
import 'package:sportRex/features/more/component/product-item.dart';

import '../../../core/commonLibs/common_libs.dart';
import '../../../shared/app_scroll_behavior.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        bodyPadding: EdgeInsets.zero,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MoreCustomAppBar().paddingAll(10),
              Gap(40 * $styles.scale),
              Text($strings.otherApps,
                  style: $styles.text.body.copyWith(
                      color: $styles.colors.tertiary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600)).paddingSymmetric(horizontal: 10),
              Gap(40 * $styles.scale),
              Container(
                decoration: const BoxDecoration(color: Color(0xff0E1648)),
                child: GridView.builder(
                  shrinkWrap: true,
                  // ignore: prefer_const_constructors
                  physics: AppScrollBehavior().getScrollPhysics(context),
                  itemCount: 8,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return const ProductItem();
                  },
                ).paddingAll(10),
              ),


            ],
          ),
        ));
  }
}
