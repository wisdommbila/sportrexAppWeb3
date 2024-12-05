import 'package:image_fade/image_fade.dart';

import '../core/commonLibs/common_libs.dart';

class AppImage extends StatelessWidget {
  const AppImage(
      {Key? key,
      required this.image,
      this.fit = BoxFit.scaleDown,
      this.alignment = Alignment.center,
      this.duration,
      this.syncDuration,
      this.distractor = false,
      this.progress = false,
      this.color,
      this.scale,
      this.width,
      this.height})
      : super(key: key);

  final ImageProvider? image;
  final BoxFit fit;
  final Alignment alignment;
  final Duration? duration;
  final Duration? syncDuration;
  final bool distractor;
  final bool progress;
  final Color? color;
  final double? scale;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ImageFade(
      image: image,
      fit: fit,
      height: height,
      width: width,
      scale: scale ?? 1,
      alignment: alignment,
      placeholder: ColoredBox(color: color ?? $styles.colors.black),
      duration: duration ?? const Duration(milliseconds: 100),
      syncDuration: syncDuration ?? const Duration(milliseconds: 100),
      loadingBuilder: (_, value, ___) {
        return Center(
            child: SizedBox(
                height: 3,
                width: 100,
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: $styles.colors.lightGrey,
                  valueColor: AlwaysStoppedAnimation($styles.colors.primary),
                )));
      },
      errorBuilder: (_, __) => Container(
        padding: EdgeInsets.all($styles.insets.xs),
        alignment: Alignment.center,
        child: LayoutBuilder(builder: (_, constraints) {
          double size =
              min(constraints.biggest.width, constraints.biggest.height);
          return Icon(
            Icons.image_not_supported_outlined,
            color: $styles.colors.greyMedium,
            size: min(size, $styles.insets.lg),
          );
        }),
      ),
    );
  }
}
