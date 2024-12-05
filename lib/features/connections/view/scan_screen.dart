// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:sportRex/core/route/routes.dart';
// import 'package:sportRex/core/util/appUtil/helper.dart';
// import 'package:sportRex/features/connections/controller/scan_screen_controller.dart';
// import 'package:sportRex/features/profile/component/profile-item.dart';
// import 'package:sportRex/shared/base_background.dart';
// import 'package:sportRex/shared/buttons.dart';

// import '../../../core/commonLibs/common_libs.dart';

// class ScanScreen extends ConsumerWidget {
//   static const routeName = "scanScreenRoute";
//   const ScanScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.watch(scanScreenProvider);
//     return Skeleton(
//         isBusy: false,
//         bodyPadding: EdgeInsets.zero,
//         appBar: BaseAppBar(
//           backBtnColor: $styles.colors.greyMedium,
//           showLeading: true,
//           centerTitle: "Scan Wallet",
//           textColor: $styles.colors.tertiary,
//           actions: [],
//         ),
//         body: BaseImageBackground(children: []));
//   }
// }
