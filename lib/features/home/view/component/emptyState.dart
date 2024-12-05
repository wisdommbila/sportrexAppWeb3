

// class BuyToken extends StatelessWidget {
//   final String? text;
//   const BuyToken({
//     super.key,
//     this.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SvgPicture.asset(
//           AppAssets.robot,
//           width: 60,
//           height: 100,
//         ),
//         Gap(20 * $styles.scale),
//         Text($strings.nothingThere,
//             style: $styles.text.bodySmall.copyWith(
//                 fontWeight: FontWeight.w400,
//                 color: $styles.colors.white,
//                 fontSize: 14.sp)),
//         Gap(20 * $styles.scale),
//         AppBtn.from(
//           onPressed: () {},
//           expand: true,
//           bgColor: $styles.colors.secondary,
//           textColor: $styles.colors.white,
//           text: text ?? $strings.buyToken,
//         ),
//       ],
//     ).paddingSymmetric(horizontal: 16);
//   }
// }
