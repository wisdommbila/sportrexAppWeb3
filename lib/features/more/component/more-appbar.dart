import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/route/routes.dart';
import 'package:sportRex/shared/app_icons.dart';

class MoreCustomAppBar extends StatelessWidget {
  const MoreCustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            $navigate.toWithParameters(AppRoutes.profile, args: true);
          },
          child: const AppIcon(
            AppIcons.profile,
            size: 24,
          ),
        ),
        const AppIcon(
          AppIcons.search,
          size: 24,
        )
      ],
    );
  }
}
