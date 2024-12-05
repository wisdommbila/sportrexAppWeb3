import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/config/constant.dart';

class TransactionHistory extends StatelessWidget {
  final DummyTransactionHistory transactionHistory;
  const TransactionHistory({
    Key? key,
    required this.transactionHistory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal:
                  BorderSide(color: $styles.colors.secondary, width: 0.4)),
        ),
        child: ListTile(
          title: Text(
            transactionHistory.title,
            style: $styles.text.body.copyWith(
                color: $styles.colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            transactionHistory.subtitle ?? "",
            style: $styles.text.body.copyWith(
                color: $styles.colors.greyMedium,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transactionHistory.amount,
                style: $styles.text.body.copyWith(
                    color: $styles.colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                transactionHistory.quantity,
                style: $styles.text.body.copyWith(
                    color: $styles.colors.greyMedium,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ));
  }
}
