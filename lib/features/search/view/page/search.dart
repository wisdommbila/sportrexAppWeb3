import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/search/controller/search_controller.dart';
import 'package:sportRex/features/search/view/component/empty_search.dart';
import 'package:sportRex/features/search/view/component/nft_search_result.dart';
import 'package:sportRex/features/search/view/ui_state/search_uistate.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/shared/line.dart';

class Search extends StatelessWidget {
  static const String route = "/Search";

  const Search({Key? key}) : super(key: key);

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
        body: SingleChildScrollView(
          child: Column(
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
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return AnimatedSwitcher(
                      duration: $styles.times.med,
                      child: switch (ref.watch(searchController).searchType) {
                        SearchType.nft => NFTSearch(),
                        SearchType.crypto => const CryptoSearchResult(),
                        _ => const EmptySearch()
                      });
                },
              ),
            ],
          ),
        ));
  }
}

class CryptoSearchResult extends StatelessWidget {
  const CryptoSearchResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: $styles.colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: $styles.colors.primary100, width: 0.2),
      ),
      child: Column(
        children: [
          AppBtn(
            onPressed: () {},
            semanticLabel: "",
            bgColor: $styles.colors.transparent,
            child: Row(
              children: [
                const AppIcon(
                  AppIcons.spt,
                  size: 40,
                ),
                Gap(20 * $styles.scale),
                Text(
                  $strings.spt,
                  style: $styles.text.body.copyWith(
                      color: $styles.colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          const HorizontalLine(),
          AppBtn(
            onPressed: () {},
            semanticLabel: "",
            bgColor: $styles.colors.transparent,
            child: Row(
              children: [
                const AppIcon(
                  AppIcons.btc,
                  isSvg: false,
                  size: 40,
                ),
                Gap(20 * $styles.scale),
                Text(
                  $strings.btc,
                  style: $styles.text.body.copyWith(
                      color: $styles.colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          const HorizontalLine(),
          AppBtn(
            onPressed: () {},
            semanticLabel: "",
            bgColor: $styles.colors.transparent,
            child: Row(
              children: [
                const AppIcon(
                  AppIcons.eth,
                  isSvg: false,
                  size: 40,
                ),
                Gap(20 * $styles.scale),
                Text(
                  $strings.eth,
                  style: $styles.text.body.copyWith(
                      color: $styles.colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
