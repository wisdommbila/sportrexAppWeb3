import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/config/constant.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/features/nft/view/nft_collectibles_screen.dart';
import 'package:sportRex/shared/app_scroll_behavior.dart';

class NftCollectionScreen extends StatelessWidget {
  static const String route = "/nftCollections";

  final DummnyNFTCollections dummnyNFTCollections;
  const NftCollectionScreen({super.key, required this.dummnyNFTCollections});

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      isBusy: false,
      bodyPadding: EdgeInsets.zero,
      isAuthSkeleton: false,
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
                  onPressed: () => $navigate.toWithParameters(
                      NftCollectiblesScreen.route,
                      args: dummnyNFTCollections.dummyNftDetails),
                  textColor: $styles.colors.white,
                  text: $strings.send,
                  // padding: EdgeInsets.zero,
                ).marginSymmetric(horizontal: 16),
              ),
            ),
          ],
        ),
      ),
      // backgroundColor: $styles.colors.primary,
      body: Stack(
        children: [
          Image.asset(
            AppAssets.nftBg,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            // height: context.dy(176),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: context.dy(378),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x00000b28), Color(0xff010e28)],
              ))),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => $navigate.back(),
                    icon: Icon(
                      Icons.arrow_back,
                      size: context.dx(20),
                    )),
                context.vSpace(20),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.zero,
                        width: context.dx(128),
                        height: context.dy(128),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                AppAssets.nftItemImage,
                              ),
                            ))),
                    context.hSpace(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dummnyNFTCollections.title1,
                                style: $styles.text.h3.copyWith(
                                  fontSize: context.dx(20),
                                  fontWeight: FontWeight.w600,
                                )),
                            Text(dummnyNFTCollections.subtitle1,
                                style: $styles.text.body.copyWith(
                                  fontSize: context.dx(12),
                                  fontWeight: FontWeight.w400,
                                ))
                          ],
                        ),
                        context.vSpace(16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dummnyNFTCollections.title2,
                                style: $styles.text.h3.copyWith(
                                  fontSize: context.dx(16),
                                  fontWeight: FontWeight.w600,
                                )),
                            Text(dummnyNFTCollections.subtitle2,
                                style: $styles.text.body.copyWith(
                                  fontSize: context.dx(12),
                                  fontWeight: FontWeight.w400,
                                ))
                          ],
                        )
                      ],
                    )
                  ],
                ),
                context.vSpace(20),
                Text(dummnyNFTCollections.name,
                    style: $styles.text.h3.copyWith(
                      fontSize: context.dx(18),
                      fontWeight: FontWeight.w600,
                    )),
                Text(dummnyNFTCollections.description,
                    style: $styles.text.body.copyWith(
                        fontSize: context.dx(14),
                        fontWeight: FontWeight.w400,
                        color: $styles.colors.greyMedium)),
                context.vSpace(23),
                Text("Collection NFTS",
                    // "$strings.collectionNFTs",
                    style: $styles.text.body.copyWith(
                      fontSize: context.dx(16),
                      fontWeight: FontWeight.w600,
                    )),
                context.vSpace(13),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    // ignore: prefer_const_constructors
                    physics: AppScrollBehavior().getScrollPhysics(context),
                    itemCount: dummnyNFTCollections.dummyNftDetails.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {},
                          child: nftPill(
                            context,
                            image: "image",
                            title: dummnyNFTCollections
                                .dummyNftDetails[index].title,
                            amount: dummnyNFTCollections
                                .dummyNftDetails[index].priceInChain,
                          ));
                    },
                  ),
                )
              ],
            ).paddingSymmetric(
              horizontal: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget nftPill(BuildContext context,
      {required String image, required String title, required String amount}) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: context.dx(164),
      height: context.dy(176),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: const Color(0xff152139)),
      child: Stack(
        children: [
          Expanded(
            child: Image.asset(
              AppAssets.nftImage,
              fit: BoxFit.fill,
              width: context.dx(164),
              height: context.dy(176),
            ),
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
