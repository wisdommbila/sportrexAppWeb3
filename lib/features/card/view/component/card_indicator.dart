import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/shared/dot_with_boder.dart';

class CardColorList extends StatelessWidget {
  final int? activeIndex;
  final List<Color> list;
  final ValueChanged<int> onPressed;
  const CardColorList(
      {Key? key,
      required this.onPressed,
      required this.activeIndex,
      required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: list.map((color) {
        return GestureDetector(
          onTap: () {
            onPressed.call(list.indexOf(color));
          },
          child: DotWithBorder(
                  backgroundColor: color,
                  boderWith: 1,
                  dotSize: 15,
                  boderColor: $styles.colors.white)
              .paddingSymmetric(horizontal: 8),
        );
      }).toList(),
    );
  }
}
