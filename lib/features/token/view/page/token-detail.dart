import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sportRex/core/config/constant.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/features/token/controller/token_description_controller.dart';
import 'package:sportRex/features/token/controller/token_price_history_repository.dart';
import 'package:sportRex/shared/app_webview.dart';

import '../../../../core/commonLibs/common_libs.dart';
import '../../../addWallet/view/component/my_indicator.dart';
import '../../model/data/token_detail_response.dart';
import '../component/line_chart.dart';

class TokenDetailsScreen extends ConsumerStatefulWidget {
  final TokenItem token;
  const TokenDetailsScreen({super.key, required this.token});

  @override
  ConsumerState<TokenDetailsScreen> createState() => _TokenDetailsScreenState();
}

class _TokenDetailsScreenState extends ConsumerState<TokenDetailsScreen> {
  @override
  initState() {
    fetchDesc();
    super.initState();
  }

  fetchDesc() {
    unawaited(ref
        .read(tokenDescriptionController.notifier)
        .fetchTokenDescription(widget.token.symbol ?? ""));
    unawaited(ref.read(tokenPriceHistoryController.notifier).fetchTokenPrices(
        widget.token.tokenAddress ?? "", widget.token.chain ?? ""));
  }

  bool _status = false;

  @override
  Widget build(
    BuildContext context,
  ) {
    // ref.read(tokenDescriptionController.notifier).fetchTokenDescription(name);
    final controller = ref.watch(tokenDescriptionController.notifier);
    final chartController = ref.watch(tokenPriceHistoryController.notifier);
    return Skeleton(
      isBusy:
          ref.watch(tokenDescriptionController.select((value) => value.isBusy)),
      bodyPadding: const EdgeInsets.symmetric(vertical: 10),
      appBar: BaseAppBar(
        backBtnColor: $styles.colors.greyMedium,
        showLeading: true,
        textColor: $styles.colors.white,
        centerTitle: widget.token.name,
      ),
      body: SingleChildScrollView(
        child: DefaultTabController(
          length: 5,
          child: Column(
            children: [
              Text(
                "\$ ${convertToDollar(amount: double.parse(widget.token.balance!), decimal: widget.token.decimals!, usdValue: widget.token.quote!.quote!.usd!.price!)}",
                style: $styles.text.body.copyWith(
                    color: $styles.colors.tertiary,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "\$${controller.tokenDescriptionResponse?.data?.quote?.usd?.price?.toStringAsFixed(4) ?? 0.0}",
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  Gap(10.sp),
                  Container(
                    height: 25.h,
                    padding: horizontalPadding(size: 5),
                    decoration: BoxDecoration(
                        color: controller.tokenDescriptionResponse?.data!.quote!
                                    .usd!.percentChange1H ==
                                null
                            ? $styles.colors.transparent
                            : controller.tokenDescriptionResponse!.data!.quote!
                                    .usd!.percentChange1H!.isNegative
                                ? $styles.colors.red
                                : $styles.colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "${controller.tokenDescriptionResponse?.data?.quote?.usd?.percentChange1H?.toStringAsFixed(4) ?? 0.0}%",
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Gap(30.sp),
              SizedBox(
                height: 250,
                width: pageWidth(context) - 0,
                child: LineChartWidget(
                  data: chartController.pricesResponse?.data?.tokenPrices ?? [],
                ),
              ).paddingOnly(left: 10, right: 25),
              Divider(
                height: 1,
                color: $styles.colors.primaryBorder,
              ),
              TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: $styles.colors.tertiary,
                  labelColor: $styles.colors.tertiary,
                  labelStyle: $styles.text.bodySmall
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 18.sp),
                  unselectedLabelStyle: $styles.text.bodySmall
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 18.sp),
                  indicatorColor: $styles.colors.primary,
                  isScrollable: false,
                  indicator: const MyTabIndicator(height: 2),
                  tabs: [
                    Tab(
                      text: $strings.oneHour,
                    ),
                    Tab(
                      text: $strings.oneDay,
                    ),
                    Tab(
                      text: $strings.oneWeek,
                    ),
                    Tab(
                      text: $strings.oneYear,
                    ),
                    Tab(
                      text: $strings.all,
                    ),
                  ]),
              Divider(
                height: 1,
                color: $styles.colors.primaryBorder,
              ),
              Gap(15 * $styles.scale),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlutterSwitch(
                    activeColor: $styles.colors.tertiary,
                    width: 40.0,
                    height: 20.0,
                    toggleSize: 18.0,
                    toggleColor: $styles.colors.primary,
                    value: _status,
                    borderRadius: 30.0,
                    onToggle: (val) {
                      setState(() {
                        _status = val;
                      });
                    },
                  ),
                  Gap(10 * $styles.scale),
                  Text(
                    $strings.priceAlert,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ).paddingSymmetric(horizontal: 10),
              Gap(20 * $styles.scale),
              Text(
                controller.tokenDescriptionResponse?.data?.description ?? "",
                style: $styles.text.body.copyWith(
                    color: $styles.colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ).paddingSymmetric(horizontal: 10),
              Gap(25 * $styles.scale),
              DecoratedBox(
                decoration: ShapeDecoration(
                  shape: $styles.shapes.roundedShape,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextTile(
                            title: $strings.marketCap,
                            value:
                                "\$ ${controller.tokenDescriptionResponse?.data?.quote?.usd?.marketCap?.toStringAsFixed(3) ?? ""}",
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        context.hSpace(8),
                        Expanded(
                          child: TextTile(
                            title: $strings.volume,
                            value:
                                "\$ ${controller.tokenDescriptionResponse?.data?.quote?.usd?.volume24H?.toStringAsFixed(3) ?? ""}",
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        )
                      ],
                    ).paddingAll(15),
                    Divider(
                      height: 1,
                      color: $styles.colors.primaryBorder,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextTile(
                            title: $strings.circulatingSupply,
                            value:
                                "${widget.token.symbol ?? ""} ${controller.tokenDescriptionResponse?.data?.circulatingSupply?.toStringAsFixed(3) ?? ""}",
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        context.hSpace(8),
                        Expanded(
                          child: TextTile(
                            title: $strings.totalSupply,
                            value:
                                "\$ ${controller.tokenDescriptionResponse?.data?.totalSupply?.toStringAsFixed(3) ?? ""}",
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ],
                    ).paddingAll(15)
                  ],
                ),
              ).paddingSymmetric(horizontal: 10),
              Gap(25 * $styles.scale),
              Divider(
                height: 1,
                color: $styles.colors.primaryBorder,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: pageWidth(context),
                decoration: BoxDecoration(
                  color: $styles.colors.primary400,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBtn.basic(
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AppWebViewScreen(
                                    url: controller.tokenDescriptionResponse
                                            ?.data?.urls?.explorer!.first ??
                                        "",
                                    title: widget.token.name,
                                  ))),
                      semanticLabel: '',
                      child: Text(
                        $strings.viewOnCoinmarket,
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.tertiary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ).paddingSymmetric(vertical: 15),
                    Divider(
                      height: 1,
                      color: $styles.colors.primaryBorder,
                    ),
                    AppBtn.basic(
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AppWebViewScreen(
                                    url: controller.tokenDescriptionResponse
                                            ?.data?.urls?.website!.first ??
                                        "",
                                    title: widget.token.symbol,
                                  ))),
                      semanticLabel: '',
                      child: Text(
                        $strings.gotoWebsite,
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.tertiary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ).paddingSymmetric(vertical: 15),
                    Divider(
                      height: 1,
                      color: $styles.colors.primaryBorder,
                    ),
                    AppBtn.basic(
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AppWebViewScreen(
                                    url: controller.tokenDescriptionResponse
                                            ?.data?.urls?.website?.first ??
                                        "",
                                    title: widget.token.symbol,
                                  ))),
                      semanticLabel: '',
                      child: Text(
                        $strings.browserExplorer,
                        style: $styles.text.body.copyWith(
                            color: $styles.colors.tertiary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ).paddingSymmetric(vertical: 15),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextTile extends StatelessWidget {
  const TextTile(
      {Key? key,
      required this.title,
      required this.crossAxisAlignment,
      required this.value})
      : super(key: key);

  final String title;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          maxLines: 1,
          style: $styles.text.body.copyWith(
              color: $styles.colors.greyMedium,
              fontSize: 12.sp,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w400),
        ),
        Text(
          value,
          maxLines: 1,
          style: $styles.text.body.copyWith(
              color: $styles.colors.tertiary,
              fontSize: 15.sp,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
