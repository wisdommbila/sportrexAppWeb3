import 'package:sportRex/core/commonLibs/common_libs.dart';

class TradePercentageButton extends StatefulWidget {
  final bool value;
  final String title;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final double size;

  const TradePercentageButton({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.size = 24.0,
  }) : super(key: key);

  @override
  State createState() => _TradePercentageButtonState();
}

class _TradePercentageButtonState extends State<TradePercentageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
            decoration: BoxDecoration(
                color: widget.value ? widget.activeColor : widget.inactiveColor,
                borderRadius: BorderRadius.circular(8)),
          ),
          const Gap(5),
          Text(widget.title,
              style: $styles.text.body.copyWith(
                  color: widget.value ? $styles.colors.white :$styles.colors.greyMedium,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}

class TradeCustomRadio extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final double size;

  const TradeCustomRadio({
    Key? key,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.size = 24.0,
  }) : super(key: key);

  @override
  State createState() => _TradeCustomRadioState();
}

class _TradeCustomRadioState extends State<TradeCustomRadio> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.options.map((option) {
        bool isSelected = option == widget.selectedOption;
        return GestureDetector(
          onTap: () {
            if (!isSelected) {
              widget.onChanged(option);
            }
          },
          child: TradePercentageButton(
            title: option,
            value: isSelected,
            onChanged: (_) {
              widget.onChanged(option);
            },
            activeColor: widget.activeColor,
            inactiveColor: widget.inactiveColor,
            size: widget.size,
          ),
        );
      }).toList(),
    );
  }
}
