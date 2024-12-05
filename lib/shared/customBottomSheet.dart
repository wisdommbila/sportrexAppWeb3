import 'package:sportRex/core/commonLibs/common_libs.dart';

import '../core/util/appUtil/helper.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 22,
    this.backgroundColor,
    this.itemCornerRadius = 0,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? $styles.colors.primary500;

    return Container(
      width: double.infinity,
      height: containerHeight,
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(30.r)),
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items.map((item) {
          var index = items.indexOf(item);
          return Expanded(
            child: InkWell(
              splashFactory:InkSparkle.splashFactory ,
              splashColor: Colors.transparent,
              onTap: () => onItemSelected(index),
              child: _ItemWidget(
                item: item,
                selectedIndex: selectedIndex,
                myIndex: index,
                iconSize: iconSize,
                isSelected: index == selectedIndex,
                backgroundColor: bgColor,
                itemCornerRadius: itemCornerRadius,
                animationDuration: animationDuration,
                curve: curve,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final int selectedIndex;
  final int myIndex;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.iconSize,
    required this.selectedIndex,
    required this.myIndex,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          isSelected ? item.activeIcon : item.inActiveIcon,
          width: iconSize,
          height: iconSize,
        ),
        verticalSpacing(spacing: 10),
        DefaultTextStyle.merge(
          style: TextStyle(
            color: isSelected
                ? item.activeColor
                : item.inactiveColor ?? item.activeColor,
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
          maxLines: 1,
          textAlign: item.textAlign,
          child: item.title,
        ),
      ],
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    required this.inActiveIcon,
    required this.activeIcon,
    required this.title,
    required this.activeColor,
    this.textAlign,
    this.inactiveColor,
  });

  final String inActiveIcon;
  final String activeIcon;
  final Widget title;
  final Color activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;
}
