import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/features/nft/view/notification_screen.dart';
import 'package:sportRex/features/token/view/page/manage_token.dart';
import 'package:sportRex/shared/app_icons.dart';

class HomeCustomAppBar extends StatelessWidget {
  const HomeCustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppBtn.basic(
          onPressed: () {
            $navigate.to(NotificationScreen.route);
          },
          semanticLabel: '',
          child: const AppIcon(
            AppIcons.notification,
            size: 24,
          ),
        ),
        Gap(10 * $styles.scale),
        GestureDetector(
          onTap: () => $navigate.to(ManageTokens.route),
          child: const AppIcon(
            AppIcons.filter,
            size: 24,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
