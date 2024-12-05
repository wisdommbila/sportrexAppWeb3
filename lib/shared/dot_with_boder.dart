import 'package:sportRex/core/commonLibs/common_libs.dart';

class DotWithBorder extends StatelessWidget {
  final Color? boderColor;
  final Color? backgroundColor;
  final double? boderWith;
  final double? dotSize;

  const DotWithBorder(
      {super.key,
      this.boderColor,
      this.backgroundColor,
      this.boderWith,
       this.dotSize});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DotWithBorderPainer(
          boderColor: boderColor,
          backgroundColor: backgroundColor,
          boderWidth: boderWith),
      size: Size.square(dotSize ?? 20),
    );
  }
}

class DotWithBorderPainer extends CustomPainter {
  final Color? boderColor;

  final Color? backgroundColor;

  final double? boderWidth;

  DotWithBorderPainer({this.boderColor, this.backgroundColor, this.boderWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      ..color = backgroundColor ?? Colors.blue
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = boderColor ?? Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = boderWidth ?? 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, fillPaint);
    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(DotWithBorderPainer oldDelegate) => false;
}
