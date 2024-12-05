import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/route/routes.dart';
import 'package:sportRex/features/card/view/component/card/debit_card.dart';
import 'package:sportRex/features/card/view/page/add_card.dart';
import 'package:sportRex/shared/base_background.dart';

class AvailableCard extends StatelessWidget {
  static const route = '/AvailableCard';
  const AvailableCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        isAuthSkeleton: false,
        bodyPadding: EdgeInsets.zero,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: $strings.debitCard,
          textColor: $styles.colors.white,
          actions: [
            AppBtn.basic(
              onPressed: () {
                $navigate.to(AddCard.route);
              },
              semanticLabel: $strings.cardDetails,
              child: Icon(
                Icons.add,
                color: $styles.colors.white,
                size: 24,
              ),
            ).paddingOnly(right: 10)
          ],
        ),
        backgroundColor: $styles.colors.primary,
        body: BaseImageBackground(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  FlipDebitCard(
                    color: $styles.colors.black,
                    onPressed: () {
                      $navigate.to(AppRoutes.cardDetail);
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
