import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/features/nft/controller/nft_details_controller.dart';
import 'package:sportRex/features/nft/model/data/nft_details_response.dart';
import 'package:sportRex/features/nft/view/nft_details_screen.dart';
import 'package:sportRex/shared/app_image.dart';
import 'package:sportRex/shared/shimmer.dart';

// ignore: must_be_immutable
class NFTTab extends ConsumerWidget {
  NFTTab({
    super.key,
  });

  List<Result> nftItems = [
    // homeNFT,
    // homeNFTCollections,
    // homeNFT,
    // homeNFTCollections,
    // homeNFT,
    // homeNFTCollections
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nftController = ref.watch(nftDetailsController.notifier);
    final state = ref.watch(nftDetailsController);
    return state.isBusy
        ? const CustomScrollView(
            slivers: [
              LoadingIndicator(),
            ],
          )
        : nftController.nftDetailsResponse == null
            ? Center(
                child: GestureDetector(
                    onTap: () => nftController.fetchNft(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: context.dy(100)),
                      child: const Text("Unable to fetch data, tap tp retry."),
                    )),
              )
            : nftController.nftDetailsResponse!.data!.result!.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.empty),
                      context.vSpace(12),
                      const Text("Looks like there’s nothing here."),
                    ],
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      return nftController.fetchNft();
                    },
                    displacement: 10,
                    backgroundColor: $styles.colors.white,
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: nftController
                          .nftDetailsResponse!.data!.result!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, mainAxisSpacing: 12),
                      itemBuilder: (BuildContext context, int index) {
                        nftItems =
                            nftController.nftDetailsResponse!.data!.result!;
                        return GestureDetector(
                          onTap: () async {
                            $navigate.toWithParameters(NftDetailsScreen.route,
                                args: nftItems[index]);



                            // await nftController.fetchNft();
                            // print(nftController.nftDetailsResponse
                            //     .toString()); // if (nftItems[index].runtimeType == DummnyNFTCollections) {
                            //   $navigate.toWithParameters(NftCollectionScreen.route,
                            //       args: nftItems[index]);
                            // } else {

                            //   $navigate.toWithParameters(NftDetailsScreen.route,
                            //       args: nftItems[index]);
                            // }
                          },
                          child: nftPill(context,
                              image: nftItems[index]
                                          .normalizedMetadata
                                          ?.image ==
                                      null
                                  ? ""
                                  : "https://nftstorage.link/ipfs/${nftItems[index].normalizedMetadata!.image!.replaceAll("ipfs://", "")}",
                              title: nftItems[index].name ?? "",
                              amount: nftController.nftDetailsResponse!.data!
                                      .result?[index].amount ??
                                  ""),
                        );
                      },
                    ).paddingSymmetric(horizontal: 16),
                  );
  }

  Widget nftPill(BuildContext context,
      {required String image, required String title, required String amount}) {
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
          // image.isNotEmpty
          // ? SvgPicture.network(
          //     image,
          //     width: context.dx(164),
          //     height: context.dy(176),
          //     fit: BoxFit.fill,
          //   )
          // :
          AppImage(
            image: NetworkImage(
              image,
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
            child: SizedBox(
              width: context.dx(150),
              child: Text(title,
                  overflow: TextOverflow.ellipsis,
                  style: $styles.text.body.copyWith(fontSize: context.dx(16))),
            ),
          )
        ],
      ),
    );
  }
}
