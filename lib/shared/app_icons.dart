// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';

///App Icon for adding custom icon
class AppIcon extends StatelessWidget {
  
  /// * Allow you add icon easily, [SVG] or [PNG] is allowed.
  ///
  /// Eg [AppIcons.search] can be added to the icon.
  ///
  /// Note add icon to your added file with icon-(icon name)
  const AppIcon(this.icon,
      {Key? key, this.size = 22, this.color, this.isSvg = true})
      : super(key: key);
  final AppIcons icon;
  final double size;
  final Color? color;
  final bool? isSvg;

  @override
  Widget build(BuildContext context) {
    String i = describeEnum(icon).toLowerCase().replaceAll('_', '-');

    String path = isSvg!
        ? 'assets/images/icons/svgs/icon-$i.svg'
        : 'assets/images/icons/pngs/icon-$i.png';

        
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: isSvg!
            ? SvgPicture.asset(
                path,
                width: size,
                height: size,
                color: color,
              )
            : Image.asset(
                path,
                width: size,
                height: size,
                filterQuality: FilterQuality.high,
              ),
      ),
    );
  }
}

enum AppIcons {
  close,
  checkbox,
  add,
  back,
  spt,
  spt_white,
  btc,
  transactionDeposit,
  transactionWithdraw,
  transactionSwap,
  forward,
  eth,
  multicoin,
  swap,
  done,
  profile,
  search,
  exchange,
  notification,
  warning,
  up,
  logo,
  logotext,
  small_qrcode,
  share,
  binance,
  mastercard,
  filter
}
