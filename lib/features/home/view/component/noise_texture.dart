

import 'package:sportRex/core/commonLibs/common_libs.dart';

class NoiseTexture extends StatelessWidget {
  const NoiseTexture({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    const noiseSize = 1;
    final noiseColor = Colors.grey.withOpacity(0.2);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return SizedBox(
          width: width,
          height: height,
          child: CustomPaint(
            painter: _NoisePainter(
              noiseSize: noiseSize,
              noiseColor: noiseColor,
              width: width,
              height: height,
              random: random,
            ),
          ),
        );
      },
    );
  }
}

class _NoisePainter extends CustomPainter {
  final int noiseSize;
  final Color noiseColor;
  final double width;
  final double height;
  final Random random;

  _NoisePainter({
    required this.noiseSize,
    required this.noiseColor,
    required this.width,
    required this.height,
    required this.random,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final noisePaint = Paint()..color = noiseColor;

    for (double x = 0; x < width; x += noiseSize.toDouble()) {
      for (double y = 0; y < height; y += noiseSize.toDouble()) {
        if (random.nextBool()) {
          canvas.drawRect(
            Rect.fromLTWH(x, y, noiseSize.toDouble(), noiseSize.toDouble()),
            noisePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(_NoisePainter oldDelegate) {
    return false;
  }
}