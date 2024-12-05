import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/route/routes.dart';
import 'package:sportRex/features/backWallet/controller/backup_pharse_controller.dart';
import 'package:sportRex/features/backWallet/view/component/checkbox-listTile.dart';
import 'package:sportRex/shared/app_image.dart';
import 'package:sportRex/shared/base_background.dart';

import '../../../../core/commonLibs/common_libs.dart';

class BackupYourWallet extends ConsumerStatefulWidget {
  const BackupYourWallet({Key? key}) : super(key: key);

  @override
  ConsumerState<BackupYourWallet> createState() => _BackupYourWalletState();
}

class _BackupYourWalletState extends ConsumerState<BackupYourWallet> {
  final List<bool> _checkboxValues = [false, false, false];

  bool _allIsNotChecked = true;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy:
            ref.watch(backupPharseController.select((value) => value.isBusy)),
        bodyPadding: EdgeInsets.zero,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          textColor: $styles.colors.white,
        ),
        backgroundColor: $styles.colors.primary,
        body: BaseImageBackground(children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    $strings.backupYourWallet,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.tertiary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  Gap(10 * $styles.scale),
                  Text(
                    $strings.loremShort,
                    style: $styles.text.body.copyWith(
                        color: $styles.colors.greyMedium,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  Center(
                    child: AppImage(
                      image: AssetImage(AppAssets.backupWalletImage.png),
                      width: $styles.scale.reactive(232),
                      fit: BoxFit.contain,
                    ),
                  ),
                  CheckboxListTileItem(
                      checkboxValue: _checkboxValues[0],
                      onChanged: (v) {
                        setState(() {
                          _checkboxValues[0] = v!;
                        });
                        checkIfAllIsChecked();
                      },
                      title: $strings.backupYourWallet1),
                  CheckboxListTileItem(
                      checkboxValue: _checkboxValues[1],
                      onChanged: (v) {
                        setState(() {
                          _checkboxValues[1] = v!;
                        });
                        checkIfAllIsChecked();
                      },
                      title: $strings.backupYourWallet2),
                  CheckboxListTileItem(
                      checkboxValue: _checkboxValues[2],
                      onChanged: (v) {
                        setState(() {
                          _checkboxValues[2] = v!;
                        });

                        checkIfAllIsChecked();
                      },
                      title: $strings.backupYourWallet3),
                  Gap(15 * $styles.scale)
                ],
              ).paddingAll(16)),
          Positioned(
            bottom: 40.h,
            right: 0,
            left: 0,
            height: 50,
            child: IgnorePointer(
              ignoring: _allIsNotChecked,
              child: AppBtn.from(
                bgColor: _allIsNotChecked == true
                    ? $styles.colors.greyMedium
                    : $styles.colors.secondary,
                onPressed: () => _submit(),
                textColor: $styles.colors.white,
                text: $strings.continueTxt,
                padding: EdgeInsets.zero,
              ).marginSymmetric(horizontal: 16),
            ),
          )
        ]));
  }

  _submit() async {
    final proceed =
        await ref.read(backupPharseController.notifier).createAccount();
    if (proceed) {
      $navigate.to(AppRoutes.backupPhrase);
    }
  }

  void checkIfAllIsChecked() {
    if (_checkboxValues.every((element) => element == true)) {
      setState(() {
        _allIsNotChecked = false;
      });
    } else {
      setState(() {
        _allIsNotChecked = true;
      });
    }
  }
}
