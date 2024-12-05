import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/service/clipboard.dart';

class PasteText extends StatelessWidget {
  final ValueChanged<String> onPasteText;
  const PasteText({super.key, required this.onPasteText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () async {
            final text = await AppClipboard.paste();
            onPasteText.call(text);
          },
          child: Text(
            "Paste",
            style: $styles.text.body.copyWith(
                color: $styles.colors.primary2,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
