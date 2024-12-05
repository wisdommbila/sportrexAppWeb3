import 'package:blurrycontainer/blurrycontainer.dart';

import '../../../../core/commonLibs/common_libs.dart';

class BlogItem extends StatelessWidget {
  const BlogItem(
      {Key? key,
      required this.title,
      required this.category,
      required this.detail,
      required this.onPressed})
      : super(key: key);

  final String title;
  final String category;
  final String detail;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            height: 260,
            width: double.infinity,
            foregroundDecoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              border: Border.all(color: $styles.colors.greyMedium, width: 0.5),
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xff152139).withOpacity(0),
                  const Color(0xff152139).withOpacity(0.94),
                ],
              ),
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.cnbctv18.com/wp-content/uploads/2021/05/Ether-e1647957866195-1019x573.jpg?impolicy=website&width=617&height=264"),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 0,
            child: BlurryContainer.expand(
              elevation: 10,
              blur: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    category,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.greyMedium,
                        fontSize: 12.8.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  Gap(5 * $styles.scale),
                  Text(
                    title,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.tertiary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Gap(5 * $styles.scale),
                  Text(
                    detail,
                    maxLines: 2,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.greyMedium,
                        fontSize: 14.sp,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ).paddingAll(5),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 5, vertical: 10),
    );
  }
}
