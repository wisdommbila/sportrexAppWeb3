import 'package:sportRex/core/commonLibs/common_libs.dart';

class CustomRadioButton extends StatefulWidget {
  final bool value;
  final String title;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final double size;

  const CustomRadioButton({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.size = 24.0,
  }) : super(key: key);

  @override
  State createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
            color: widget.value ? widget.activeColor : widget.inactiveColor,
            borderRadius: BorderRadius.circular(8)),
        child: Text(widget.title,
            style: $styles.text.body.copyWith(
                color: $styles.colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}


class CustomRadioGroup extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final double size;

  const CustomRadioGroup({
    Key? key,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.size = 24.0,
  }) : super(key: key);

  @override
  State createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<CustomRadioGroup> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.options.map((option) {
        bool isSelected = option == widget.selectedOption;
        return GestureDetector(
          onTap: () {
            if (!isSelected) {
              widget.onChanged(option);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomRadioButton(
              title: option,
              value: isSelected,
              onChanged: (_) {
                widget.onChanged(option);
              },
              activeColor: widget.activeColor,
              inactiveColor: widget.inactiveColor,
              size: widget.size,
            ),
          ),
        );
      }).toList(),
    );
  }
}
