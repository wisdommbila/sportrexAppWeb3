import 'package:sportRex/core/extension/extension.dart';
import 'package:sportRex/shared/app_image.dart';

import '../../../../core/commonLibs/common_libs.dart';

class OnboardingPage extends StatelessWidget {
  final String? image;
  final String? title;
  final String? desc;
  const OnboardingPage({Key? key, this.image, this.desc, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppImage(
          image: AssetImage(image!),
          width: context.dy(280),
        ),
        context.vSpace(24),
        Container(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
            child: Column(
              children: [
                Text(
                  title!,
                  style: $styles.text.h3,
                  textAlign: TextAlign.center,
                ),
                context.vSpace(16),
                Text(
                  desc!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: $styles.text.body,
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      ],
    );
  }
}
