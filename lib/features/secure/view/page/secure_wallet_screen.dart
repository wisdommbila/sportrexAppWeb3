// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sportRex/core/commonLibs/common_libs.dart';
// import 'package:sportRex/core/extension/extension.dart';
// import 'package:sportRex/core/util/appUtil/app_strings.dart';
// import 'package:sportRex/core/util/app_text_field.dart';
// import 'package:sportRex/features/secure/controller/secure_wallet_controller.dart';
// import 'package:sportRex/features/secure/view/page/secure_wallet_pin_screen.dart';
// import 'package:sportRex/shared/app_icons.dart';
// import 'package:sportRex/shared/base_background.dart';
//
// class SecureWalletScreen extends HookConsumerWidget {
//   static const route = '/secureWalletScreen';
//
//   const SecureWalletScreen({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final ensIdController = useTextEditingController();
//
//     final controller = ref.watch(secureWalletProvider);
//     return Skeleton(
//         bodyPadding: EdgeInsets.zero,
//         backgroundColor: $styles.colors.primary,
//         isBusy: false,
//         isAuthSkeleton: false,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: IconButton(
//             icon: const AppIcon(AppIcons.back),
//             onPressed: () => $navigate.back(),
//           ),
//         ),
//         body: BaseImageBackground(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   context.vSpace(40),
//                   Text(
//                     AppString.secureYourWallet,
//                     style: $styles.text.h3,
//                   ),
//                   context.vSpace(14),
//                   Text(
//                     AppString.inputENS,
//                     style: $styles.text.title1.copyWith(
//                         fontWeight: FontWeight.w400,
//                         color: $styles.colors.white),
//                   ),
//                   context.vSpace(20),
//                   AppTextField(
//                     title: AppString.ENSID.toUpperCase(),
//                     hintText: AppString.ENSID,
//                     optionalText: "optional",
//                     onChanged: controller.onBtnActiveChange,
//                     controller: ensIdController,
//                   ),
//                   context.vSpace(157),
//                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                     TextButton(
//                         onPressed: () =>
//                             $navigate.to(SecureWalletPinScreen.route),
//                         child: Text(
//                           AppString.skip,
//                           style: $styles.text.btn.copyWith(
//                               color: $styles.colors.white,
//                               fontWeight: FontWeight.w600),
//                         )),
//                   ]),
//                   AppBtn.from(
//                     onPressed: () => controller.isBtnActive == true
//                         ? $navigate.to(SecureWalletPinScreen.route)
//                         : {},
//                     text: AppString.proceede,
//                     isSecondary: true,
//                     bgColor: controller.isBtnActive == true
//                         ? $styles.colors.primary2
//                         : $styles.colors.greyMedium,
//                     expand: true,
//                   ),
//                   context.vSpace(48),
//                   Center(
//                     child: (buildIndicators(context)),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
//
//   Row buildIndicators(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         const SizedBox(width: 8),
//         Container(
//           height: context.dy(4),
//           width: context.dx(24),
//           color: $styles.colors.primary2,
//         ),
//         const SizedBox(width: 8),
//         Container(
//           height: context.dy(4),
//           width: context.dx(24),
//           color: const Color(0xFFD9D9D9),
//         ),
//       ],
//     );
//   }
// }
