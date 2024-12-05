import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/colorUtils/color_utils.dart';

class CardActionButton extends StatelessWidget {
  final String? btnTitle;
  final String? btnImage;
  final VoidCallback onPressed;

  const CardActionButton(
      {super.key,
      required this.btnTitle,
      required this.btnImage,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBtn.basic(
      onPressed: onPressed,
      semanticLabel: $strings.send,
      child: Column(
        children: [
          Container(
              height: 56,
              width: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: const Alignment(0.00, -1.00),
                  end: const Alignment(0, 1),
                  colors: [
                    $styles.colors.tertiary,
                    ColorUtils.parseHex("#D4E2FF")
                  ],
                ),
              ),
              child: SizedBox(
                height: 32,
                width: 32,
                child: SvgPicture.asset(
                  btnImage ?? AppAssets.send,

                ),
              )),
          const Gap(5),
          Text(
            btnTitle ?? "",
            style: $styles.text.body.copyWith(
                color: $styles.colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
