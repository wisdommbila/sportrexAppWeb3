import '../../../core/commonLibs/common_libs.dart';
import '../../../shared/app_image.dart';

class WalletItem extends StatelessWidget {
  const WalletItem(
      {Key? key,
      required this.title,
      this.subTitle,
      this.isPrimary = false,
      required this.onPressed})
      : super(key: key);

  final String title;
  final String? subTitle;
  final bool? isPrimary;
  final Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: $styles.colors.primary400,
        border: Border.symmetric(
            horizontal:
                BorderSide(color: $styles.colors.primaryBorder, width: 0.5)),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: $styles.colors.tertiary,
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  child: SvgPicture.asset(
                    "wallet".svg,
                    width: 24,
                    height: 24,
                  ),
                ).paddingAll(10),
              ),
              if (isPrimary!)
                Positioned(
                    right: -5,
                    top: -5,
                    child: CircleAvatar(
                        radius: 8,
                        backgroundColor: $styles.colors.white,
                        child: AppImage(
                          image: AssetImage(AppAssets.check),
                        ))),
            ],
          ),
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
              if (subTitle != null) ...[
                Text(
                  subTitle!,
                  style: $styles.text.body.copyWith(
                      color: $styles.colors.greyMedium,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
              ]
            ],
          ),
          const Spacer(),

          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              size: 30,
            ),
            onSelected: onPressed,
            itemBuilder: ((context) {
              return [
                if (!isPrimary!)
                  PopupMenuItem(
                    value: "default",
                    child: Text(
                      "Set as default",
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.tertiary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                PopupMenuItem(
                  value: "name",
                  child: Text(
                    "Edit Name",
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.tertiary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ];
            }),
          ),
          // IconButton(
          //
          //   onPressed: onPressed,
          // )
        ],
      ).paddingOnly(left: 10),
    );
  }
}
