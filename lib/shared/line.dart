import '../core/commonLibs/common_libs.dart';

class HorizontalLine extends StatelessWidget {
  final Color? color;
  final double? thickness;
  const HorizontalLine({super.key, this.color,this.thickness});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness??.2,
      color: color??$styles.colors.primary100,
      height: 0,
    );
  }
}


class VerticalLine extends StatelessWidget {
  final Color? color;
  final double? thickness;
  const VerticalLine({
    super.key,this.color,this.thickness
  });

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      thickness: 1.5,
      color: $styles.colors.lightGrey,
      width: 10 * $styles.scale,
    );
  }
}
