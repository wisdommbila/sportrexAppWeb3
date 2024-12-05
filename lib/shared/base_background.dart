import '../core/commonLibs/common_libs.dart';

class BaseImageBackground extends StatelessWidget {
  final List<Widget> children;

  ///Add sportRex Base Image to the Background...
  ///list of [Widget] can be passed as it children
  const BaseImageBackground({Key? key, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              AppAssets.authBackground,
              fit: BoxFit.cover,
            )),
        ...children
      ],
    );
  }
}
