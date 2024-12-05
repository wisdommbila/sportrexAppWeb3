import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sportRex/core/config/dependecies.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';

class AppTextField extends StatefulWidget {
  final String? hintText;
  final String? title;
  final String? optionalText;

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool obscureText;
  final bool readOnly;
  final bool floatHint;
  final String? initialValue;
  final Widget? prefixWidget;
  final bool? isPassword;
  final Widget? suffixWidget;
  final TextInputAction textInputAction;
  final TextInputType? textInputType;
  final int minLines;
  final int maxLines;
  final Color? filledColor;
  final Function()? onTap;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.enabled = true,
    this.obscureText = false,
    this.readOnly = false,
    this.initialValue,
    this.textInputAction = TextInputAction.next,
    this.textInputType,
    this.inputFormatters,
    this.floatHint = false,
    this.prefixWidget,
    this.minLines = 1,
    this.maxLines = 1,
    this.onTap,
    this.suffixWidget,
    this.isPassword = false,
    this.title,
    this.optionalText,
    this.textAlign,
    this.filledColor,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title!,
                      style: $styles.text.title1
                          .copyWith(color: $styles.colors.white)),
                  widget.optionalText != null
                      ? Text(widget.optionalText!,
                          style: $styles.text.title1
                              .copyWith(color: $styles.colors.white))
                      : const SizedBox.shrink(),
                ],
              )
            : const SizedBox.shrink(),
        widget.title != null ? const SizedBox(height: 6) : const SizedBox(),
        TextFormField(
          style: textTheme.titleMedium!.copyWith(color: $styles.colors.white),
          controller: widget.controller,
          onChanged: widget.onChanged,
          validator: widget.validator,
          onSaved: widget.onSaved,
          onTap: widget.onTap,
          autofocus: false,
          textAlign: widget.textAlign ?? TextAlign.start,
          enabled: widget.enabled,
          obscureText: widget.isPassword! ? _visible : false,
          readOnly: widget.onTap != null || widget.readOnly,
          initialValue: widget.initialValue,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          minLines: widget.minLines,
          maxLines: widget.minLines > widget.maxLines
              ? widget.minLines
              : widget.maxLines,
          decoration: InputDecoration(
            constraints: BoxConstraints(maxHeight: 98.h, minHeight: 50.h),
            filled: widget.filledColor != null ? true : false,
            prefixIcon: widget.prefixWidget == null
                ? null
                : Padding(
                    padding: EdgeInsets.only(left: 11.w, right: 11.w),
                    child: widget.prefixWidget,
                  ),
            suffixIcon: widget.suffixWidget ??
                (widget.isPassword!
                    ? IconButton(
                        icon: _visible
                            ? const Icon(
                                Icons.visibility,
                                color: Color(0xffacacac),
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: Color(0xffacacac),
                              ),
                        onPressed: () {
                          setState(() {
                            _visible = !_visible;
                          });
                        },
                      )
                    : null),
            fillColor: widget.filledColor ?? $styles.colors.transparent,
            hintText: widget.floatHint ? null : widget.hintText,
            enabled: widget.enabled,
            labelText: widget.floatHint ? widget.hintText : null,
            labelStyle:
                textTheme.titleMedium!.copyWith(color: $styles.colors.black),
            hintStyle: textTheme.titleMedium!
                .copyWith(color: $styles.colors.greyMedium),
            floatingLabelStyle: textTheme.bodySmall!
                .copyWith(color: $styles.colors.black, fontSize: 14.sp),
            enabledBorder: enabledBorder,
            disabledBorder: disableBorder,
            focusedBorder: focusedBorder,
            border: focusedBorder,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          ),
        ),
      ],
    );
  }
}

final OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(width: 0.5, color: $styles.colors.primary100));

final OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(width: 0.5, color: $styles.colors.primary100));

final OutlineInputBorder disableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(width: 0.5, color: $styles.colors.primary100));

class MoneyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (isNotEmpty(newValue.text)) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final f = NumberFormat("#,###");
      final number =
          int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(number);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}

class MoneyTextField extends StatelessWidget {
  final String? hintText;
  final String? title;
  final String? optionalText;
  final bool? enabled;

  final bool? readOnly;

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;

  const MoneyTextField(
      {super.key,
      this.hintText,
      this.title,
      this.readOnly,
      this.enabled,
      this.optionalText,
      this.controller,
      this.onChanged,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly ?? false,
      enabled: enabled ?? true,
      showCursor: false,
      controller: controller,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.number,
      inputFormatters: [MoneyFormatter()],
      style: $styles.text.body.copyWith(
          color: $styles.colors.white,
          fontSize: 30.sp,
          fontWeight: FontWeight.bold),
      onChanged: (value) {
        onChanged?.call(value);
      },
      decoration: InputDecoration(
        hintText: hintText ?? '0',

        hintStyle: TextStyle(
            color: $styles.colors.white,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold), // Customize hint text color
        focusedBorder: InputBorder.none, // Remove focused border
        enabledBorder: InputBorder.none, // Remove default border
        errorBorder: InputBorder.none, // Remove error border
        disabledBorder: InputBorder.none, // Remove disabled border
      ),
    );
  }
}

class SearchTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool obscureText;
  final bool readOnly;
  final bool floatHint;
  final String? initialValue;
  final Widget? prefixWidget;
  final bool? isPassword;
  final Widget? suffixWidget;
  final TextInputAction textInputAction;
  final TextInputType? textInputType;
  final int minLines;
  final int maxLines;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;

  const SearchTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.enabled = true,
    this.obscureText = false,
    this.readOnly = false,
    this.initialValue,
    this.textInputAction = TextInputAction.next,
    this.textInputType,
    this.inputFormatters,
    this.floatHint = false,
    this.prefixWidget,
    this.minLines = 1,
    this.maxLines = 1,
    this.onTap,
    this.suffixWidget,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return TextFormField(
      style: textTheme.titleMedium!.copyWith(color: $styles.colors.black),
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: widget.validator,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      autofocus: false,
      enabled: widget.enabled,
      obscureText: widget.isPassword! ? _visible : false,
      readOnly: widget.onTap != null || widget.readOnly,
      initialValue: widget.initialValue,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      minLines: widget.minLines,
      maxLines:
          widget.minLines > widget.maxLines ? widget.minLines : widget.maxLines,
      decoration: InputDecoration(
        constraints: BoxConstraints(maxHeight: 98.h, minHeight: 50.h),
        filled: true,
        prefixIcon: widget.prefixWidget == null
            ? null
            : Padding(
                padding: EdgeInsets.only(left: 11.w, right: 11.w),
                child: widget.prefixWidget,
              ),
        suffixIcon: widget.suffixWidget ??
            (widget.isPassword!
                ? IconButton(
                    icon: _visible
                        ? const Icon(
                            Icons.visibility,
                            color: Color(0xffacacac),
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Color(0xffacacac),
                          ),
                    onPressed: () {
                      setState(() {
                        _visible = !_visible;
                      });
                    },
                  )
                : null),
        fillColor: $styles.colors.white,
        hintText: widget.floatHint ? null : widget.hintText,
        enabled: widget.enabled,
        labelText: widget.floatHint ? widget.hintText : null,
        labelStyle:
            textTheme.titleMedium!.copyWith(color: $styles.colors.black),
        hintStyle:
            textTheme.titleMedium!.copyWith(color: $styles.colors.greyMedium),
        floatingLabelStyle: textTheme.bodySmall!
            .copyWith(color: $styles.colors.black, fontSize: 14.sp),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: $styles.colors.transparent)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: $styles.colors.transparent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: $styles.colors.transparent)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: $styles.colors.transparent)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      ),
    );
  }
}
