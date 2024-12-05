import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/config/constant.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/shared/app_image.dart';
import 'package:sportRex/shared/app_scroll_behavior.dart';

import '../../../../core/commonLibs/common_libs.dart';
import '../../../shared/dailog_sheet.dart';

class NftCollectionDetailsScreen extends ConsumerStatefulWidget {
  final List<DummnyNFTDetails> dummnyNFTDetails;
  static const route = "/nftCollectionDetailsRoute";
  const NftCollectionDetailsScreen({Key? key, required this.dummnyNFTDetails})
      : super(key: key);

  @override
  ConsumerState<NftCollectionDetailsScreen> createState() =>
      _NftCollectionDetailsScreenState();
}

final textController = TextEditingController();

class _NftCollectionDetailsScreenState
    extends ConsumerState<NftCollectionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Skeleton(
      isBusy: false,
      appBar: BaseAppBar(
        centerTitle: "NFT details",
        backBtnColor: $styles.colors.greyMedium,
        showLeading: true,
        textColor: $styles.colors.white,
        actions: const [],
      ),
      bottomSheet: Container(
        color: $styles.colors.primary,
        padding: EdgeInsets.symmetric(
            vertical: context.dy(16), horizontal: context.dx(16)),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: context.dy(16)),
                child: AppBtn.from(
                  bgColor: $styles.colors.secondary,
                  onPressed: () => showSizeSheet(
                    context,SizedBox()
                    // SendNFTBottomsheet(
                    //
                    // ),
                  ),
                  textColor: $styles.colors.white,
                  text: $strings.send,
                  // padding: EdgeInsets.zero,
                ).marginSymmetric(horizontal: 16),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: $styles.colors.primary,
      body: SingleChildScrollView(
        physics: AppScrollBehavior().getScrollPhysics(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: context.dy(296),
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                // onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
              ),
              items: widget.dummnyNFTDetails.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return AppImage(
                      image: AssetImage(
                        i.image,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: context.dy(296),
                    );
                  },
                );
              }).toList(),
            ),
            context.vSpace(20),
            Text("Artsry Collection",
                style: $styles.text.body.copyWith(
                    fontSize: context.dx(14),
                    fontWeight: FontWeight.w400,
                    color: $styles.colors.greyMedium)),
            Text(widget.dummnyNFTDetails.first.name,
                style: $styles.text.h3.copyWith(
                  fontSize: context.dx(18),
                  fontWeight: FontWeight.w600,
                )),
            Text(widget.dummnyNFTDetails.first.description,
                style: $styles.text.body.copyWith(
                    fontSize: context.dx(14),
                    fontWeight: FontWeight.w400,
                    color: $styles.colors.greyMedium)),
            context.vSpace(23),
            Text("Price",
                style: $styles.text.body.copyWith(
                    fontSize: context.dx(14),
                    fontWeight: FontWeight.w400,
                    color: $styles.colors.greyMedium)),
            Row(
              children: [
                Text(widget.dummnyNFTDetails.first.priceInUsd,
                    style: $styles.text.h3.copyWith(
                      fontSize: context.dx(14),
                      fontWeight: FontWeight.w600,
                    )),
                context.hSpace(8),
                Text(widget.dummnyNFTDetails.first.priceInChain,
                    style: $styles.text.body.copyWith(
                        fontSize: context.dx(14),
                        fontWeight: FontWeight.w400,
                        color: $styles.colors.greyMedium)),
              ],
            ),
            context.vSpace(23),
            Text("Contract address",
                style: $styles.text.body.copyWith(
                    fontSize: context.dx(14),
                    fontWeight: FontWeight.w400,
                    color: $styles.colors.greyMedium)),
            Text(widget.dummnyNFTDetails.first.contactAddress,
                style: $styles.text.h3.copyWith(
                  fontSize: context.dx(14),
                  fontWeight: FontWeight.w600,
                )),
            context.vSpace(23),
            Text("Token ID",
                style: $styles.text.body.copyWith(
                    fontSize: context.dx(14),
                    fontWeight: FontWeight.w400,
                    color: $styles.colors.greyMedium)),
            Text(widget.dummnyNFTDetails.first.tokenID,
                style: $styles.text.h3.copyWith(
                  fontSize: context.dx(14),
                  fontWeight: FontWeight.w600,
                )),
            context.vSpace(23),
            Text("Blockchain",
                style: $styles.text.body.copyWith(
                    fontSize: context.dx(14),
                    fontWeight: FontWeight.w400,
                    color: $styles.colors.greyMedium)),
            Text(widget.dummnyNFTDetails.first.blockChain,
                style: $styles.text.h3.copyWith(
                  fontSize: context.dx(14),
                  fontWeight: FontWeight.w600,
                )),
            context.vSpace(100),
          ],
        ),
      ),
    );
  }

}
