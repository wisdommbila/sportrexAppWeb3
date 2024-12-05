import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/dex/controller/swap_list_controller.dart';
import 'package:sportRex/features/dex/model/token_swap.dart';
import 'package:sportRex/shared/app_image.dart';
import 'package:sportRex/shared/emptystate.dart';
import 'package:sportRex/shared/item_state.dart';
import 'package:sportRex/shared/loader.dart';

class ItemSwapPage extends ConsumerStatefulWidget {
  static const String route = "/ItemSwapPage";

  const ItemSwapPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ItemSwapPage> createState() => _ItemSwapPageState();
}

class _ItemSwapPageState extends ConsumerState<ItemSwapPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
    super.initState();
  }

  void _init() {}

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        bodyPadding: EdgeInsets.zero,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: $strings.swap,
          textColor: $styles.colors.white,
        ),
        body: RefreshIndicator(
          color: $styles.colors.primary,
          backgroundColor: $styles.colors.white,
          onRefresh: () async {
            await ref.read(swapListController.notifier).getSwapToken();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20 * $styles.scale),
              Text($strings.searchHere,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.greyMedium,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400))
                  .paddingSymmetric(horizontal: 16),
              Gap(20 * $styles.scale),
              AppTextField(
                controller:
                    ref.read(swapListController.notifier).searchController,
                onChanged: (searchItem) {
                  ref.read(swapListController.notifier).search(searchItem);
                },
                hintText: $strings.typeSomething,
              ).paddingSymmetric(horizontal: 16),
              Gap(20 * $styles.scale),
              Expanded(
                child: ItemView(
                  loader: const ListLoader(),
                  emptyState: GestureDetector(
                    onTap: () {
                      ref.read(swapListController.notifier).getSwapToken();
                    },
                    child: const SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: EmptyState()),
                  ),
                  items: ref.watch(swapListController
                      .select((value) => value.allSwapTokens)),
                  isAdsLoading: ref.watch(
                      swapListController.select((value) => value.isBusy)),
                  itemViewBuilder: (BuildContext context, Widget? child,
                      List<SwapTokens> items) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SwapTokenItemWidget(
                          swapTokens: items[index],
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}

class SwapTokenItemWidget extends StatelessWidget {
  final SwapTokens swapTokens;

  const SwapTokenItemWidget({super.key, required this.swapTokens});

  @override
  Widget build(BuildContext context) {
    return AppBtn.basic(
      onPressed: () {
        $navigate.backWithParameters(args: swapTokens);
      },
      semanticLabel: '',
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        decoration: BoxDecoration(
            color: $styles.colors.primary100.withOpacity(0.25),
            border: Border(
              top: BorderSide(width: 0.5, color: $styles.colors.primary100),
              bottom: BorderSide(width: 0.5, color: $styles.colors.primary100),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  AppImage(
                    color: $styles.colors.transparent,
                    height: 40,
                    width: 40,
                    image: NetworkImage(swapTokens.logoUri ?? ''),
                  ),
                  Gap(20 * $styles.scale),
                  Expanded(
                    child: Text(
                      swapTokens.symbol ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            Gap(30 * $styles.scale),
            Text("0.0",
                style: $styles.text.body.copyWith(
                    color: $styles.colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
