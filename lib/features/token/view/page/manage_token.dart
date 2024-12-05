import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/app_text_field.dart';
import 'package:sportRex/features/search/controller/search_controller.dart';
import 'package:sportRex/features/search/view/component/empty_search.dart';
import 'package:sportRex/features/search/view/component/nft_search_result.dart';
import 'package:sportRex/features/search/view/ui_state/search_uistate.dart';
import 'package:sportRex/features/token/controller/token_controller.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/line.dart';

import '../../../../core/util/appUtil/debouncer.dart';
import '../../../../shared/dailog_sheet.dart';
import '../../model/data/import_network_tokens_response.dart';
import '../component/add_custom_token.dart';

class ManageTokens extends ConsumerStatefulWidget {
  static const String route = "/manageToken";

  const ManageTokens({Key? key}) : super(key: key);

  @override
  ConsumerState<ManageTokens> createState() => _ManageTokensState();
}

class _ManageTokensState extends ConsumerState<ManageTokens> {
  final _debouncer = Debouncer(milliseconds: 1500);

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(tokenDetailsController.notifier);
    // ignore: unused_local_variable
    final update = ref.watch(tokenDetailsController);
    return Skeleton(
        isBusy:
        ref.watch(tokenDetailsController.select((value) => value.isBusy)),
        bodyPadding: EdgeInsets.zero,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          backIcon: AppIcons.add,
          backPressed: () {
            showSizeSheet(
                context,
                AddCustomToken(
                  onSubmit: () {
                    controller.saveToken(
                        controller.importNetworkTokensResponse?.data
                          ?..isActive = true);
                    $navigate.back();
                  },
                  networksResponse: controller.chainListResponse!,
                ));
          },
          showLeading: true,
          centerTitle: $strings.token,
          actions: [
            TextButton(
                onPressed: () {
                  $navigate.back();
                },
                child: Text(
                  $strings.done,
                  style: $styles.text.body.copyWith(
                      color: $styles.colors.secondary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ))
          ],
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
                        _debouncer.run(() {
                          ref
                              .read(tokenDetailsController.notifier)
                              .fetchNetworkTokens(tokenName: value);
                        });

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
                        SearchType.crypto => CryptoSearchResult(
                          tokens: controller.combinedTokens,
                          ref: ref,
                        ),
                        _ => const EmptySearch()
                      });
                },
              ),
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class CryptoSearchResult extends StatefulWidget {
  CryptoSearchResult({
    super.key,
    this.tokens,
    this.ref,
  });

  List<ImportedTokenData>? tokens;
  WidgetRef? ref;

  @override
  State<CryptoSearchResult> createState() => _CryptoSearchResultState();
}

class _CryptoSearchResultState extends State<CryptoSearchResult> {
 
  // bool? _status = false;

  @override
  Widget build(BuildContext context) {
    final controller = widget.ref?.read(tokenDetailsController.notifier);
    // final update = widget.ref?.watch(tokenDetailsController);
    return Container(
      decoration: BoxDecoration(
        color: $styles.colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: $styles.colors.primary100, width: 0.2),
      ),
      child: Column(
        children: [
          ListView.builder(
              itemCount: widget.tokens?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return AppBtn.basic(
                  onPressed: () {},
                  semanticLabel: '',
                  child: Container(
                    height: 65,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: $styles.colors.primary,
                        border: Border(
                            bottom: BorderSide(
                                color: $styles.colors.secondary, width: 0.15))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (widget.tokens![index].logo !=
                                null &&
                                widget.tokens![index].logo!
                                    .isNotEmpty)
                              Image.network(
                                  widget.tokens![index].logo!)
                            else
                              const AppIcon(
                                AppIcons.spt,
                                size: 40,
                              ),
                            const Gap(15),
                            Text(
                                widget.tokens![index].symbol! ==
                                    "WBTC"
                                    ? "Bitcoin"
                                    : widget.tokens![index].name!,
                                style: $styles.text.title2.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: $styles.colors.white,
                                    fontSize: 18.sp)),
                            const Gap(5),
                            if (widget.tokens![index].platform != null)
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: const Color(0xff152139),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                    widget.tokens![index].platform!.name!,
                                    style: $styles.text.title2.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: $styles.colors.white,
                                        fontSize: 8.sp)),
                              ),
                          ],
                        ),
                        FlutterSwitch(
                          activeColor: $styles.colors.tertiary,
                          width: 40.0,
                          height: 20.0,
                          toggleSize: 18.0,
                          toggleColor: $styles.colors.primary,
                          value: widget.tokens![index].isActive!,
                          borderRadius: 30.0,
                          onToggle: (val) {
                            if (widget.tokens![index].isActive!) {
                              controller?.validateToken(
                                  widget.tokens![index], false);
                            } else {
                              controller?.saveToken(ImportedTokenData(
                                  name: widget.tokens![index].name,
                                  symbol:
                                  widget.tokens![index].symbol,
                                  chain:
                                  widget.tokens![index].chain,
                                  contractAddress: widget
                                      .tokens![index]
                                      .contractAddress,
                                  logo: widget.tokens![index].logo,
                                  isActive: true));
                            }
                          },
                        ),
                        // const AppIcon(AppIcons.checkbox),
                      ],
                    ),
                  ),
                );
              }),
          const HorizontalLine(),
        ],
      ),
    );
  }
}