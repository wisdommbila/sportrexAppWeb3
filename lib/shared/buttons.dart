import 'package:sportRex/shared/app_icons.dart';

import '../core/commonLibs/common_libs.dart';

/// Shared methods across button types
Widget _buildIcon(BuildContext context, AppIcons icon,
        {required bool isSecondary, required double? size, Color? iconColor}) =>
    AppIcon(icon,
        color: iconColor ?? (isSecondary ? $styles.colors.primary : iconColor),
        size: size ?? 18);

/// The core button that drives all other buttons.
class AppBtn extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  AppBtn({
    Key? key,
    required this.onPressed,
    required this.semanticLabel,
    this.enableFeedback = true,
    this.pressEffect = true,
    this.child,
    this.padding,
    this.canDisable = false,
    this.expand = false,
    this.isSecondary = false,
    this.circular = false,
    this.minimumSize,
    this.borderRadius,
    this.bgColor,
    this.border,
  })  : _builder = null,
        super(key: key);

  AppBtn.from({
    Key? key,
    required this.onPressed,
    this.enableFeedback = true,
    this.pressEffect = true,
    this.padding,
    this.canDisable = false,
    this.expand = false,
    this.isSecondary = false,
    this.minimumSize,
    this.bgColor,
    this.border,
    this.borderRadius,
    String? semanticLabel,
    String? text,
    TextStyle? textStyle,
    Color? textColor,
    Color? iconColor,
    AppIcons? icon,
    double? iconSize,
  })  : child = null,
        circular = false,
        super(key: key) {
    if (semanticLabel == null && text == null) {
      throw ('AppBtn.from must include either text or semanticLabel');
    }
    this.semanticLabel = semanticLabel ?? text ?? '';

    _builder = (context) {
      if (text == null && icon == null) return const SizedBox.shrink();
      Text? txt = text == null
          ? null
          : Text(text,
              style: textStyle ??
                  $styles.text.btn.copyWith(
                      color: textColor ?? $styles.colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
              textHeightBehavior:
                  const TextHeightBehavior(applyHeightToFirstAscent: false));
      Widget? icn = icon == null
          ? null
          : _buildIcon(context, icon,
              isSecondary: isSecondary, size: iconSize, iconColor: iconColor);
      if (txt != null && icn != null) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [icn, Gap($styles.insets.xs), txt],
        );
      } else {
        return (txt ?? icn)!;
      }
    };
  }

  // ignore: prefer_const_constructors_in_immutables
  AppBtn.basic({
    Key? key,
    required this.onPressed,
    required this.semanticLabel,
    this.enableFeedback = true,
    this.pressEffect = true,
    this.child,
    this.canDisable = false,
    this.padding = EdgeInsets.zero,
    this.isSecondary = false,
    this.circular = false,
    this.minimumSize,
    this.borderRadius,
  })  : expand = false,
        bgColor = Colors.transparent,
        border = null,
        _builder = null,
        super(key: key);

  // interaction:
  final VoidCallback? onPressed;
  late final String semanticLabel;
  final bool enableFeedback;

  // content:
  late final Widget? child;
  late final WidgetBuilder? _builder;

  // layout:
  final EdgeInsets? padding;
  final bool expand;
  final bool circular;
  final Size? minimumSize;

  // style:
  final bool isSecondary;
  final BorderSide? border;
  final Color? bgColor;
  final bool pressEffect;
  final double? borderRadius;
  final bool? canDisable;

  @override
  Widget build(BuildContext context) {
    Color defaultColor =
        isSecondary ? $styles.colors.white : $styles.colors.primary;
    Color textColor = isSecondary ? $styles.colors.black : $styles.colors.white;
    BorderSide side = border ?? BorderSide.none;

    bool isDisableButton = canDisable ?? false;

    Widget content =
        _builder?.call(context) ?? child ?? const SizedBox.shrink();

    if (expand) content = Center(child: content);

    OutlinedBorder shape = circular
        ? CircleBorder(side: side)
        : RoundedRectangleBorder(
            side: side,
            borderRadius:
                BorderRadius.circular(borderRadius ?? $styles.corners.md));

    ButtonStyle style = ButtonStyle(
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize ?? Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashFactory: NoSplash.splashFactory,
      backgroundColor:
          ButtonStyleButton.allOrNull<Color>(bgColor ?? defaultColor),
      overlayColor: ButtonStyleButton.allOrNull<Color>(Colors.transparent),
      // disable default press effect
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(
          padding ?? EdgeInsets.all($styles.insets.md)),
      enableFeedback: enableFeedback,
    );

    ///Style for a button that can be disabled
    final elevatedButtonStyle = ElevatedButton.styleFrom(
        minimumSize: minimumSize ?? Size.zero,
        disabledBackgroundColor: $styles.colors.greyMedium.withOpacity(0.5),
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashFactory: NoSplash.splashFactory,
        backgroundColor: bgColor ?? defaultColor,
        shape: shape,
        padding: padding ?? EdgeInsets.all($styles.insets.md),
        enableFeedback: enableFeedback);

    Widget button = isDisableButton
        ? ElevatedButton(
            onPressed: onPressed,
            style: elevatedButtonStyle,
            child: DefaultTextStyle(
              style:
                  DefaultTextStyle.of(context).style.copyWith(color: textColor),
              child: content,
            ),
          )
        : TextButton(
            onPressed: onPressed,
            style: style,
            child: DefaultTextStyle(
              style:
                  DefaultTextStyle.of(context).style.copyWith(color: textColor),
              child: content,
            ),
          );

    // add press effect:
    if (pressEffect) button = _ButtonPressEffect(button);

    // add semantics?
    if (semanticLabel.isEmpty) return button;

    return Semantics(
      label: semanticLabel,
      button: true,
      container: true,
      child: ExcludeSemantics(child: button),
    );
  }
}

/// //////////////////////////////////////////////////
/// _ButtonDecorator
/// Add a transparency-based press effect to buttons.
/// //////////////////////////////////////////////////
class _ButtonPressEffect extends StatefulWidget {
  const _ButtonPressEffect(this.child, {Key? key}) : super(key: key);
  final Widget child;

  @override
  State<_ButtonPressEffect> createState() => _ButtonPressEffectState();
}

class _ButtonPressEffectState extends State<_ButtonPressEffect> {
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      onTapDown: (_) => setState(() => _isDown = true),
      onTapUp: (_) => setState(() => _isDown = false),
      // not called, TextButton swallows this.
      onTapCancel: () => setState(() => _isDown = false),
      behavior: HitTestBehavior.translucent,
      child: Opacity(
        opacity: _isDown ? 0.7 : 1,
        child: ExcludeSemantics(child: widget.child),
      ),
    );
  }
}
