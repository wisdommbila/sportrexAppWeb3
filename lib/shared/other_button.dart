import 'package:sportRex/shared/app_icons.dart';

import '../core/commonLibs/common_libs.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({
    Key? key,
    this.icon = AppIcons.back,
    this.onPressed,
    this.semanticLabel,
    this.bgColor,
    this.iconColor,
  }) : super(key: key);

  final Color? bgColor;
  final Color? iconColor;
  final AppIcons icon;
  final VoidCallback? onPressed;
  final String? semanticLabel;

  const BackBtn.close(
      {Key? key, VoidCallback? onPressed, Color? bgColor, Color? iconColor})
      : this(
            key: key,
            icon: AppIcons.close,
            onPressed: onPressed,
            semanticLabel: "buttonsSemanticClose",
            bgColor: bgColor,
            iconColor: iconColor);

  @override
  Widget build(BuildContext context) {
    return AppBtn.basic(
      onPressed: onPressed ?? () => Navigator.pop(context),
      semanticLabel: semanticLabel ?? "buttonsSemanticBack",
      child: AppIcon(
        icon,
        color: iconColor,
        isSvg: true,
      ),
    );
  }

  Widget safe() => _SafeAreaWithPadding(child: this);
}

class _SafeAreaWithPadding extends StatelessWidget {
  const _SafeAreaWithPadding({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.all($styles.insets.sm),
        child: child,
      ),
    );
  }
}
