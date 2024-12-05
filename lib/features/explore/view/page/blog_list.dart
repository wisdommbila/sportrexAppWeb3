
import 'package:sportRex/core/route/routes.dart';
import 'package:sportRex/features/explore/view/component/blog_item.dart';

import '../../../../core/commonLibs/common_libs.dart';

class BlogList extends StatelessWidget {
  const BlogList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlogItem(
                  title: "The Biggest Dip Yet",
                  category: "New York Times",
                  detail:
                      "Lorem ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo. ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo.ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo.ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo.ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo.ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo.ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo.",
                  onPressed: () => $navigate.to(
                        AppRoutes.blogDetail,
                      )),
            ],
          ),
        ));
  }
}
