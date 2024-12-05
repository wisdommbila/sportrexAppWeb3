import '../../../../core/commonLibs/common_libs.dart';
import '../../../token/view/component/transaction-item.dart';

class CardTransactions extends StatelessWidget {
  const CardTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [

      TransactionItem(
        leftTitle: "\$ 5,457.00",
        rightTitle: "0.00046532",
        rightValue: "Completed",
        leftValue: "08/09/21 10:00:31",
        icon: 'transaction-deposit'.svg,
      ),
      TransactionItem(
        leftTitle: "\$ 5,457.00",
        rightTitle: "0.00046532",
        rightValue: "Completed",
        leftValue: "08/09/21 10:00:31",
        icon: 'transaction-withdraw'.svg,
      ),
    ],);
  }
}
