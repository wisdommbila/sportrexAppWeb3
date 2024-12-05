import 'package:sportRex/core/route/routes.dart';

import '../../../../core/commonLibs/common_libs.dart';

enum TransactionType { DEPOSIT, SWAP, WITHDRAWAL }

class TransactionItem extends StatelessWidget {
  const TransactionItem(
      {Key? key,
      required this.leftTitle,
      required this.rightTitle,
      required this.rightValue,
      required this.leftValue,
      required this.icon})
      : super(key: key);

  final String leftTitle;
  final String rightValue;
  final String rightTitle;
  final String leftValue;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => $navigate.to(AppRoutes.transactionDetail),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal:
                BorderSide(color: $styles.colors.primaryBorder, width: 1),
          ),
          color: $styles.colors.primary400,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                icon,
                width: 40,
                height: 40,
              ),
              Gap(10 * $styles.scale),
              _TextTile(
                  title: leftTitle,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  value: leftValue),
              const Spacer(),
              _TextTile(
                  title: rightTitle.toString(),
                  crossAxisAlignment: CrossAxisAlignment.end,
                  value: rightValue)
            ],
          ),
        ),
      ),
    );
  }
}

class _TextTile extends StatelessWidget {
  const _TextTile(
      {Key? key,
      required this.title,
      required this.crossAxisAlignment,
      required this.value})
      : super(key: key);

  final String title;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: $styles.text.body.copyWith(
              color: $styles.colors.tertiary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: $styles.text.body.copyWith(
              color: $styles.colors.greyMedium,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
