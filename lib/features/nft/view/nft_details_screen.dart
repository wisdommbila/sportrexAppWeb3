import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/features/nft/component/send_nft_botomsheet.dart';
import 'package:sportRex/features/nft/model/data/nft_details_response.dart';
import 'package:sportRex/shared/app_image.dart';
import 'package:sportRex/shared/app_scroll_behavior.dart';

import '../../../../core/commonLibs/common_libs.dart';
import '../../../shared/dailog_sheet.dart';
import '../../performTransaction/controller/perform_transaction_controller.dart';

class NftDetailsScreen extends ConsumerStatefulWidget {
  final Result nft;
  static const route = "/nftDetailsRoute";
  const NftDetailsScreen({Key? key, required this.nft}) : super(key: key);

  @override
  ConsumerState<NftDetailsScreen> createState() => _NftDetailsScreenState();
}

final textController = TextEditingController();

class _NftDetailsScreenState extends ConsumerState<NftDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Skeleton(
      isBusy: ref.watch(performTransactionController.select((value) => value)),
      appBar: BaseAppBar(
        centerTitle: "NFT details",
        backBtnColor: $styles.colors.greyMedium,
        showLeading: true,
        textColor: $styles.colors.white,
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
                      context,
                      const SendNFTBottomsheet(
                          // onSubmit: () {
                          //   // $navigate.toWithParameters(PerformTransaction.route,
                          //   //     args: PerformTransactionType.send);
                          //   $navigate.back();
                          //   showSizeSheet(context, const SuccessBottomsheet());
                          )),
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
            AppImage(
              image: NetworkImage(
                widget.nft.normalizedMetadata?.image ==
                    null
                    ? ""
                    : "https://nftstorage.link/ipfs/${widget.nft.normalizedMetadata?.image!.replaceAll("ipfs://", "")}",
              ),
              width: double.infinity,
              fit: BoxFit.cover,
              height: context.dy(296),
            ),
            context.vSpace(20),
            Text(widget.nft.normalizedMetadata?.name ?? "",
                style: $styles.text.h3.copyWith(
                  fontSize: context.dx(18),
                  fontWeight: FontWeight.w600,
                )),
            Text(widget.nft.normalizedMetadata?.description ?? "",
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
                Text("\$${widget.nft.amount} ",
                    style: $styles.text.h3.copyWith(
                      fontSize: context.dx(14),
                      fontWeight: FontWeight.w600,
                    )),
                context.hSpace(8),
                Text("\$${widget.nft.amount} ",
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
            Text(widget.nft.tokenAddress ?? "",
                style: $styles.text.h3.copyWith(
                  fontSize: context.dx(14),
                  fontWeight: FontWeight.w600,
                )),
            context.vSpace(23),
            Text("Contract Type",
                style: $styles.text.body.copyWith(
                    fontSize: context.dx(14),
                    fontWeight: FontWeight.w400,
                    color: $styles.colors.greyMedium)),
            Text(widget.nft.contractType ?? "",
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
            Text(widget.nft.tokenId ?? "",
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
            Text(widget.nft.name ?? "",
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
