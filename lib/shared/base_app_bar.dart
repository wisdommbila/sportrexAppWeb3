import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/shared/app_icons.dart';
import 'package:sportRex/shared/other_button.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar(
      {super.key,
      this.backgroundColor,
      this.centerTitle,
      this.actions,
      this.showLeading = true,
      this.backPressed,
      this.textColor,
      this.toolbarHeight,
        this.backIcon = AppIcons.back,
      this.backBtnColor});

  final String? centerTitle;
  final List<Widget>? actions;
  final VoidCallback? backPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? backBtnColor;
  final bool? showLeading;
  final AppIcons? backIcon;
  final double? toolbarHeight;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor ?? $styles.colors.transparent,
      leading: Visibility(
        visible: showLeading!,
        child: BackBtn(
          icon: backIcon!,
          iconColor: backBtnColor,
          onPressed: backPressed ??
              () {
                $navigate.back();
              },
        ),
      ),
      centerTitle: true,
      toolbarHeight: toolbarHeight,
      title: Text(centerTitle ?? "",
          textAlign: TextAlign.center,
          style: $styles.text.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              color: textColor ?? $styles.colors.black,
              fontSize: 20.sp)),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
