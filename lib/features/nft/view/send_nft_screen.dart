import 'package:sportRex/core/config/constant.dart';
import 'package:sportRex/core/extension/extension.dart';

import '../../../../core/commonLibs/common_libs.dart';
import '../../../core/util/app_text_field.dart';
import '../../../shared/app_scroll_behavior.dart';
import 'nft_collections_screen.dart';

class SendNftScreen extends StatefulWidget {
  static const route = "/sendNftRoute";

  const SendNftScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SendNftScreen> createState() => _SendNftScreenState();
}

class _SendNftScreenState extends State<SendNftScreen> {
  List<DummnyNFTDetails> newNftList = [];

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        appBar: BaseAppBar(
          // centerTitle: "Collectibles",
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          textColor: $styles.colors.white,
        ),
        backgroundColor: $styles.colors.primary,
        body: Column(
          children: [
            const AppTextField(
              title: "Search here",
              hintText: "Type Something",
              // optionalText: "optional",
              // onChanged: controller.onBtnActiveChange,
              // controller: ensIdController,
            ),
            Gap(40 * $styles.scale),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                // ignore: prefer_const_constructors
                physics: AppScrollBehavior().getScrollPhysics(context),
                itemCount: homeNFTCollections.dummyNftDetails.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => $navigate.toWithParameters(
                        NftCollectionScreen.route,
                        args: homeNFTCollections),
                    child: GridItem(
                      item: homeNFTCollections.dummyNftDetails[index],
                      isSelected: (bool value) {
                        setState(() {
                          if (value) {
                            newNftList
                                .add(homeNFTCollections.dummyNftDetails[index]);
                          } else {
                            newNftList.remove(
                                homeNFTCollections.dummyNftDetails[index]);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ));
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
                  style: $styles.text.body.copyWith(fontSize: context.dx(14)))),
          Positioned(
            bottom: 36,
            left: 12,
            child: Text(widget.item.name,
                style: $styles.text.body.copyWith(fontSize: context.dx(16))),
          ),
        ],
      ),
    );
  }
}
