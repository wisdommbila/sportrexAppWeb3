import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/search/controller/search_controller.dart';

import '../../../home/view/component/nft_tab.dart';

class SendNftPage extends StatelessWidget {
  static const String route = "/SendNftPage";

  const SendNftPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        bodyPadding: EdgeInsets.zero,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: "",
          textColor: $styles.colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(20 * $styles.scale),
            Align(
              alignment: Alignment.topLeft,
              child: Text($strings.searchHere,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.greyMedium,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400))
                  .paddingSymmetric(horizontal: 16),
            ),
            Gap(20 * $styles.scale),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) =>
                  AppTextField(
                hintText: $strings.typeSomething,
                onChanged: (value) {
                  ref.read(searchController.notifier).performSearch(value);
                },
              ).paddingSymmetric(horizontal: 16),
            ),
            Gap(20 * $styles.scale),
            Expanded(child: NFTTab())

            // NFTSearch(),
          ],
        ));
  }
}
