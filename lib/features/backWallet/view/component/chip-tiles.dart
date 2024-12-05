import '../../../../core/commonLibs/common_libs.dart';

class ChipTile extends StatelessWidget {
  const ChipTile({Key? key, required this.value}) : super(key: key);

  final List<String> value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: ShapeDecoration(
          color: const Color(0xFF020D26),
          shape: $styles.shapes.roundedShape,
        ),
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Wrap(
              spacing: 4,
              children: value.map((word) {
                return Chip(
                  backgroundColor: $styles.colors.secondary,
                  label: Text(word,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.tertiary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400)),
                );
              }).toList(),
            )));
  }
}
