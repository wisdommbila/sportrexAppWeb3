import 'package:sportRex/core/config/constant.dart';
import 'package:sportRex/core/extension/extension.dart';

import '../../../../core/commonLibs/common_libs.dart';

class NotificationScreen extends StatefulWidget {
  static const route = "/notificationScreenRoute";

  const NotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<DummnyNFTDetails> newNftList = [];

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        appBar: BaseAppBar(
          centerTitle: "Notifications",
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          textColor: $styles.colors.white,
        ),
        backgroundColor: $styles.colors.primary,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(
                        color: $styles.colors.secondary, width: 0.4)),
              ),
              child: ListTile(
                isThreeLine: true,
                title: Text(
                  "Bet Won",
                  style: $styles.text.body.copyWith(
                      color: $styles.colors.green,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo........",
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.greyMedium,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "08/09/21",
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.greyMedium,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            )
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
