
import '../../../../core/commonLibs/common_libs.dart';

class TransactionDetail extends StatelessWidget {
  const TransactionDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: "Deposit Details",
          textColor: $styles.colors.tertiary,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Gap(50 * $styles.scale),
              Text(
                $strings.amount,
                style: $styles.text.body.copyWith(
                    color: $styles.colors.greyMedium,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "0.0000456  ETH",
                style: $styles.text.body.copyWith(
                    color: $styles.colors.tertiary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                $strings.completed,
                style: $styles.text.body.copyWith(
                    color: $styles.colors.green,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
              Gap(50 * $styles.scale),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: $styles.colors.primary400,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const TextTile(title: "Network", value: "ETH"),
                      Gap(30 * $styles.scale),
                       TextTile(
                          title: $strings.address,
                          value: "bgececwvhdfhfyr736ur3fhfyr736ur3"),
                      Gap(30 * $styles.scale),
                       TextTile(
                          title: $strings.transactionFee,
                          value:
                          "0.005678"),
                      Gap(30 * $styles.scale),
                       TextTile(
                          title: $strings.txid,
                          value:
                              "bgececwvhdfhfyr736ur348jshrw33fsdvcdc65ddfdf635ggdgf"),
                      Gap(30 * $styles.scale),
                       TextTile(
                          title: $strings.date, value: "04-08-2021   10:00:31"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class TextTile extends StatelessWidget {
  const TextTile({Key? key, required this.title, required this.value})
      : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: $styles.text.body.copyWith(
              color: $styles.colors.greyMedium,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400),
        ),
        const Gap(30),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: $styles.text.body.copyWith(
                color: $styles.colors.tertiary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
