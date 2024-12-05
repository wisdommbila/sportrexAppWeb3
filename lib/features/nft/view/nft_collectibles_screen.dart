import 'package:sportRex/core/config/constant.dart';
import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/shared/app_image.dart';

import 'package:sportRex/shared/app_scroll_behavior.dart';

import '../../../../core/commonLibs/common_libs.dart';
import '../../../core/util/appUtil/app_strings.dart';
import 'nft_collection_details_screen.dart';

class NftCollectiblesScreen extends StatefulWidget {
  final List<DummnyNFTDetails> dummnyNftCollectibles;
  static const route = "/nftCollectiblesRoute";

  const NftCollectiblesScreen({Key? key, required this.dummnyNftCollectibles})
      : super(key: key);

  @override
  State<NftCollectiblesScreen> createState() => _NftCollectiblesScreenState();
}

class _NftCollectiblesScreenState extends State<NftCollectiblesScreen> {
  List<DummnyNFTDetails> newNftList = [];

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      isBusy: false,
      appBar: BaseAppBar(
        centerTitle: "Collectibles",
        backBtnColor: $styles.colors.greyMedium,
        showLeading: true,
        textColor: $styles.colors.white,
        actions: [
          TextButton(
              onPressed: () => newNftList.isNotEmpty
                  ? $navigate.toWithParameters(NftCollectionDetailsScreen.route,
                      args: newNftList)
                  : {},
              child: Text(
                AppString.next,
                style: $styles.text.btn.copyWith(
                    color: $styles.colors.white, fontWeight: FontWeight.w600),
              )),
        ],
      ),
      backgroundColor: $styles.colors.primary,
      body: GridView.builder(
        shrinkWrap: true,
        // ignore: prefer_const_constructors
        physics: AppScrollBehavior().getScrollPhysics(context),
        itemCount: widget.dummnyNftCollectibles.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridItem(
            item: widget.dummnyNftCollectibles[index],
            isSelected: (bool value) {
              setState(() {
                if (value) {
                  newNftList.add(widget.dummnyNftCollectibles[index]);
                } else {
                  newNftList.remove(widget.dummnyNftCollectibles[index]);
                }
              });
            },
          );
        },
      ),
    );
  }
}

class GridItem extends StatefulWidget {
  final DummnyNFTDetails item;
  final ValueChanged<bool> isSelected;

  const GridItem({
    super.key,
    required this.item,
    required this.isSelected,
  });

  @override
  State createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected(isSelected);
        });
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: context.dx(164),
        height: context.dy(176),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: const Color(0xff152139)),
        child: Stack(
          children: [
            Image.asset(
              AppAssets.nftImage,
              fit: BoxFit.fill,
              width: context.dx(164),
              height: context.dy(176),
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
                child: Text(widget.item.priceInChain,
                    style:
                        $styles.text.body.copyWith(fontSize: context.dx(14)))),
            Positioned(
              bottom: 36,
              left: 12,
              child: Text(widget.item.name,
                  style: $styles.text.body.copyWith(fontSize: context.dx(16))),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: isSelected
                  ? CircleAvatar(
                      radius: 12,
                      backgroundColor: $styles.colors.white,
                      child: AppImage(
                        image: AssetImage(AppAssets.check),
                      ))
                  : CircleAvatar(
                      radius: 12,
                      backgroundColor: $styles.colors.white,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
