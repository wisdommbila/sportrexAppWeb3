import 'package:sportRex/features/card/view/component/card-button.dart';
import 'package:sportRex/features/card/view/component/card-transactions.dart';
import 'package:sportRex/features/card/view/component/card/debit_card.dart';
import 'package:sportRex/features/card/view/component/dialog/withdraw-fund.dart';
import 'package:sportRex/features/card/view/component/item-detail.dart';

import '../../../../core/commonLibs/common_libs.dart';
import '../../../../core/util/appUtil/helper.dart';
import '../../../../shared/dailog_sheet.dart';
import '../../../addWallet/view/component/my_indicator.dart';
import '../component/dialog/fund-card-dialog.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({Key? key}) : super(key: key);

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(vsync: this, length: 2);

  bool isDetail = true;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      isBusy: false,
      bodyPadding: EdgeInsets.zero,
      appBar: BaseAppBar(
        backBtnColor: $styles.colors.greyMedium,
        showLeading: true,
        centerTitle: $strings.cardDetails,
        textColor: $styles.colors.white,
        actions: [
          if (isDetail)
            Icon(
              Icons.remove_red_eye_outlined,
              color: $styles.colors.greyMedium,
              size: 24,
            ),
          const Gap(10)
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppAssets.authBackground,
                ))),
        child: SingleChildScrollView(
          child: SizedBox(
            height: pageHeight(context),
            child: Column(
              children: [
                FlipDebitCard(
                  color: $styles.colors.black,
                ),
                Gap(20 * $styles.scale),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CardActionButton(
                        btnTitle: "Fund Card",
                        btnImage: "sendicon".svg,
                        onPressed: () {
                          showSizeSheet(context, FundCardDialog(
                            onSubmit: () {
                              $navigate.back();
                              // $navigate.to(SecureWalletScreen.route);
                            },
                          ));
                        }),
                    Gap(30 * $styles.scale),
                    CardActionButton(
                        btnTitle: "Withdraw",
                        btnImage: "receiveicon".svg,
                        onPressed: () {
                          showSizeSheet(context, WithdrawFundDialog(
                            onSubmit: () {
                              $navigate.back();
                              // $navigate.to(SecureWalletScreen.route);
                            },
                          ));
                        }),
                  ],
                ),
                Gap(24 * $styles.scale),
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                          color: $styles.colors.primaryBorder, width: 1),
                    ),
                  ),
                  child: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: $styles.colors.greyMedium,
                      labelColor: $styles.colors.white,
                      labelStyle: $styles.text.bodySmall.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 18.sp),
                      unselectedLabelStyle: $styles.text.bodySmall.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 18.sp),
                      indicatorColor: $styles.colors.primary,
                      labelPadding: const EdgeInsets.only(right: 50),
                      indicator: const MyTabIndicator(height: 2),
                      onTap: (val) {
                        setState(() {
                          isDetail = val == 0 ? true : false;
                        });
                      },
                      tabs: [
                        Tab(
                          text: $strings.details,
                        ),
                        Tab(
                          text: $strings.transaction,
                        ),
                      ]),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    controller: _tabController,
                    children: const [ItemDetails(), CardTransactions()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
