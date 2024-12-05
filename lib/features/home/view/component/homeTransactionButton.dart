import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/extension/extension.dart';

class HomeTransactionButton extends StatelessWidget {
  final String? btnTitle;
  final String? btnImage;
  final VoidCallback onPressed;

  const HomeTransactionButton(
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
          SvgPicture.asset(
            btnImage ?? AppAssets.send,
            width: context.dx(38),
            height: context.dx(38),
          ),
          const Gap(5),
          Text(
            btnTitle ?? "",
            style: $styles.text.body.copyWith(
                color: $styles.colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
