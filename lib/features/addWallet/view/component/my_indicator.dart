import '../../../../core/commonLibs/common_libs.dart';

class MyTabIndicator extends Decoration {
  final double? height;

  const MyTabIndicator({this.height});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _MyTabIndicatorPainter(this, onChanged, height);
  }
}

class _MyTabIndicatorPainter extends BoxPainter {
  final MyTabIndicator decoration;

  final double? height;

  _MyTabIndicatorPainter(this.decoration, VoidCallback? onChanged, this.height)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint();
    paint.shader = const LinearGradient(
      colors: [
        Color(0xFFFAC744),
        Color(0xFF8B14EF),
        Color(0xFF3333FF),
      ],
    ).createShader(rect);

    const radius = Radius.circular(5);

    final double indicatorHeight = height ?? 2.0;

    final Rect indicatorRect = Rect.fromLTWH(
      rect.left,
      rect.bottom - indicatorHeight,
      rect.width,
      indicatorHeight,
    );

    canvas.drawRRect(
      RRect.fromRectAndCorners(indicatorRect, topLeft: radius, topRight: radius, bottomLeft: Radius.zero, bottomRight: Radius.zero),
      paint,
    );
    // canvas.drawRect(indicatorRect, paint);
  }
}
