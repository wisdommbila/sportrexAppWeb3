import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/styleaUtils/themScaffold.dart';
import 'package:sportRex/features/home/view/page/home.dart';
import 'package:sportRex/features/more/view/more.dart';
import 'package:sportRex/features/profile/view/profile.dart';
import 'package:sportRex/shared/customBottomSheet.dart';

import '../../../dex/view/page/dex.dart';
import '../../../explore/view/page/explore.dart';

class DashBoard extends ConsumerStatefulWidget {
  static const String route = "/DashBoardRoot";

  const DashBoard({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _DashBoardState();
}

class _DashBoardState extends ConsumerState<DashBoard>
    with SingleTickerProviderStateMixin {
  int selectIndex = 0;

  final List<Widget> _tabWidgets = [
    ThemeScaffold(child: const Home()),
    ThemeScaffold(child: const DexPage()),
    ThemeScaffold(child: const ExplorePage()),
    ThemeScaffold(child: const Profile()),
    ThemeScaffold(child: const More()),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: selectIndex,
        containerHeight: 75.h,
        showElevation: false,
        iconSize: 24,
        items: [
          BottomNavyBarItem(
            inActiveIcon: AppAssets.homeInActive,
            activeIcon: AppAssets.homeActive,
            activeColor: $styles.colors.white,
            inactiveColor: $styles.colors.white,
            title: Text($strings.home),
          ),
          BottomNavyBarItem(
            inActiveIcon: AppAssets.dexInActive,
            activeIcon: AppAssets.dexActive,
            activeColor: $styles.colors.white,
            inactiveColor: $styles.colors.white,
            title: Text($strings.dex),
          ),
          BottomNavyBarItem(
            inActiveIcon: AppAssets.exploreInActive,
            activeIcon: AppAssets.exploreActive,
            activeColor: $styles.colors.white,
            inactiveColor: $styles.colors.white,
            title: Text($strings.explore),
          ),
          BottomNavyBarItem(
            inActiveIcon: AppAssets.settingInactive,
            activeIcon: AppAssets.settingActive,
            activeColor: $styles.colors.white,
            inactiveColor: $styles.colors.white,
            title: Text($strings.settings),
          ),
          BottomNavyBarItem(
            inActiveIcon: AppAssets.moreInActive,
            activeIcon: AppAssets.moreActive,
            activeColor: $styles.colors.white,
            inactiveColor: $styles.colors.white,
            title: Text($strings.more),
          ),
        ],
        onItemSelected: (int index) {
          setState(() {
            selectIndex = index;
          });
        },
      ),
      bodyPadding: EdgeInsets.zero,
      isBusy: false,
      backgroundColor: $styles.colors.primary,
      body: IndexedStack(
        alignment: AlignmentDirectional.topCenter,
        index: selectIndex,
        children: _tabWidgets,
      ),
    );
  }
}
