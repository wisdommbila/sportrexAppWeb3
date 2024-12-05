import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/config/constant.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/features/nft/view/nft_collections_screen.dart';
import 'package:sportRex/features/nft/view/nft_details_screen.dart';
import 'package:sportRex/shared/app_image.dart';

class NFTSearch extends StatelessWidget {
  NFTSearch({
    super.key,
  });

  final List nftItems = [
    homeNFT,
    homeNFTCollections,
    homeNFT,
    homeNFTCollections,
    homeNFT,
    homeNFTCollections
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: pageHeight(context),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: nftItems.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 12),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (nftItems[index].runtimeType == DummnyNFTCollections) {
                $navigate.toWithParameters(NftCollectionScreen.route,
                    args: nftItems[index]);
              } else {
                $navigate.toWithParameters(NftDetailsScreen.route,args: nftItems[index]);
              }
            },
            child: NftPill(
                context: context,
                image: "image",
                title: nftItems[index].name,
                amount: nftItems[index].priceInChain),
          );
        },
      ).paddingSymmetric(horizontal: 16),
    );
  }
}

class NftPill extends StatelessWidget {
  const NftPill({
    super.key,
    required this.context,
    required this.image,
    required this.title,
    required this.amount,
  });

  final BuildContext context;
  final String image;
  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: context.dx(164),
      height: context.dy(176),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: const Color(0xff152139)),
      child: Stack(
        children: [
          AppImage(
            image: AssetImage(
              AppAssets.nftImage,
            ),
            width: context.dx(164),
            height: context.dy(176),
            fit: BoxFit.fill,
            progress: true,
          ),
          Container(
              width: context.dx(164),
              height: context.dy(176),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x00152139), Color(0xef152139)],
                  ))),
          Positioned(
              bottom: 8,
              left: 12,
              child: Text(amount,
                  style: $styles.text.body.copyWith(fontSize: context.dx(14)))),
          Positioned(
            bottom: 36,
            left: 12,
            child: Text(title,
                style: $styles.text.body.copyWith(fontSize: context.dx(16))),
          )
        ],
      ),
    );
  }
}
