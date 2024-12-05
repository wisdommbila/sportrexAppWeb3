import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/features/addWallet/view/component/my_indicator.dart';
import 'package:sportRex/features/explore/view/page/blog_list.dart';

class ExplorePage extends StatefulWidget {
  static const route = '/ImportOtherWallet';

  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(vsync: this, length: 2);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        bodyPadding: EdgeInsets.zero,
        isAuthSkeleton: false,
        appBar: BaseAppBar(
          centerTitle: $strings.explore,
          textColor: $styles.colors.tertiary,
          showLeading: false,
        ),
        backgroundColor: $styles.colors.primary,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: pageHeight(context),
              child: Column(
                children: [
                  const Gap(5),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                          width: 0.5, color: $styles.colors.primary100),
                      bottom: BorderSide(
                          width: 0.5, color: $styles.colors.primary100),
                    )),
                    child: TabBar(
                        controller: _tabController,
                        unselectedLabelColor:
                            $styles.colors.tertiary.withOpacity(0.2),
                        labelColor: $styles.colors.tertiary,
                        labelStyle: $styles.text.bodySmall.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 18.sp),
                        unselectedLabelStyle: $styles.text.bodySmall.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 18.sp),
                        indicatorColor: $styles.colors.primary,
                        labelPadding: const EdgeInsets.all(1),
                        indicator: const MyTabIndicator(),
                        tabs: [
                          Tab(
                            text: $strings.sportrexBlog,
                          ),
                          Tab(
                            text: $strings.news,
                          ),
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        controller: _tabController,
                        children: const [BlogList(), BlogList()]),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
