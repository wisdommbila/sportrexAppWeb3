import '../../../../core/commonLibs/common_libs.dart';

class CheckboxListTileItem extends StatelessWidget {
  const CheckboxListTileItem(
      {Key? key,
      required this.checkboxValue,
      required this.onChanged,
      required this.title})
      : super(key: key);

  final bool checkboxValue;
  final void Function(bool?)? onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
      horizontalTitleGap: 0,
      leading:  Checkbox(
          checkColor: $styles.colors.tertiary,
          
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          fillColor: MaterialStateProperty.all($styles.colors.transparent),
          side: MaterialStateBorderSide.resolveWith(
            (states) => BorderSide(
              width: 2.0,
              color: $styles.colors.tertiary,
            ),
          ),
          value: checkboxValue,
          onChanged: onChanged,
        ),
      title: Text(
        title,
        style: $styles.text.body.copyWith(
            color: $styles.colors.tertiary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
