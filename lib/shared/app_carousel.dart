import 'package:carousel_slider/carousel_slider.dart';
import 'package:sportRex/core/extension/extension.dart';

import '../core/commonLibs/common_libs.dart';
import 'app_image.dart';

class AppCarousel extends StatelessWidget {
  final List<String> sliderImages;
  const AppCarousel({Key? key, required this.sliderImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: context.dy(50),
        padEnds: false,
        viewportFraction: 0.37,
        initialPage: 0,
        // enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(milliseconds: 100),
        autoPlayAnimationDuration: const Duration(milliseconds: 900),
        autoPlayCurve: Curves.linear,
        enlargeCenterPage: true,
        enlargeFactor: 0.0,
        // onPageChanged: callbackFunction,
        scrollDirection: Axis.horizontal,
      ),
      items: sliderImages.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return AppImage(
              image: AssetImage(
                i,
              ),
              // width: MediaQuery.of(context).size.width,
              // height: context.dy(296),
            );
          },
        );
      }).toList(),
    );
  }
}
