import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/extension/extension.dart';

class AppDropdown extends StatelessWidget {
  final List<String>? items;
  final String? hintText;
  final Widget? suffixIcon;
  final String? errorText;
  final String? value;
  final Color? borderColor;
  final String? labelText;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const AppDropdown({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.labelText,
    this.borderColor,
    this.suffixIcon,
    this.errorText,
    this.hintText,
    this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      items: items?.map(
        (String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item.toString(),
              style: $styles.text.body,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ).toList(),
      onChanged: onChanged,
      style: $styles.text.h2,
      value: value,
      validator: validator,
      icon: Icon(
        Icons.arrow_drop_down,
        color: $styles.colors.black,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            TextStyle(color: $styles.colors.black, fontSize: context.dx(14)),
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: $styles.text.h2,
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade900, width: 1),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade900, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? $styles.colors.primary,
            width: 2,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
    );
  }
}
