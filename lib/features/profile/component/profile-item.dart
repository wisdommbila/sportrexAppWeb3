import '../../../core/commonLibs/common_libs.dart';

class ProfileItem extends StatelessWidget {
  const  ProfileItem({Key? key, required this.image, required this.title, this.subTitle, required this.onPressed}) : super(key: key);

  final String image;
  final String title;
  final String? subTitle;
 final  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: $styles.colors.primary400,
          border: Border.symmetric(
              horizontal: BorderSide(
                  color: $styles.colors.primaryBorder, width: 0.5)),
        ),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: $styles.colors.tertiary,
                    borderRadius: BorderRadius.circular(10)),
                child: SvgPicture.asset(
                  image,
                  width: 24,
                  height: 24,
                ).paddingAll(10)),
            Gap(20 * $styles.scale),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: $styles.text.body.copyWith(
                      color: $styles.colors.tertiary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),

                if(subTitle != null)...[

                  Text(
                    subTitle!,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ]

              ],
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_right,
              size: 30,
            )
          ],
        ).paddingSymmetric(horizontal: 15),
      ),
    );
  }
}
