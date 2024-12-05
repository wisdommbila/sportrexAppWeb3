import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/features/backWallet/controller/backup_pharse_controller.dart';
import 'package:sportRex/shared/base_background.dart';

import '../../../../core/commonLibs/common_libs.dart';
import '../../../../core/route/routes.dart';
import '../component/chip-tiles.dart';

class BackupPhrase extends ConsumerStatefulWidget {
  const BackupPhrase({Key? key}) : super(key: key);

  @override
  ConsumerState<BackupPhrase> createState() => _BackupPhraseState();
}

class _BackupPhraseState extends ConsumerState<BackupPhrase> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.read(backupPharseController.notifier);
    return Skeleton(
        isBusy: false,
        bodyPadding: EdgeInsets.zero,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          // backPressed: () {},
          textColor: $styles.colors.white,
          centerTitle: $strings.backUpPhrase,
        ),
        body: BaseImageBackground(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      $strings.backupPhraseHeaderText,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.greyMedium,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    Gap(20 * $styles.scale),
                    Text(
                      $strings.backUpPhrase,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.tertiary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    ChipTile(value: controller.seedPhrase)
                        .paddingOnly(bottom: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton.icon(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: controller.seedPhrase.join(' ')));
                            $toastService.showSuccess("Copied!!");
                          },
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(BorderSide(
                                  width: 1, color: $styles.colors.greyMedium))),
                          icon: Icon(
                            Icons.copy,
                            color: $styles.colors.greyMedium,
                          ),
                          label: Text(
                            $strings.copy,
                            style: $styles.text.body.copyWith(
                                color: $styles.colors.greyMedium,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          )),
                    ),
                  ],
                ).paddingAll(16)),
            Positioned(
              bottom: 40.h,
              right: 0,
              left: 0,
              height: 50,
              child: AppBtn.from(
                bgColor: $styles.colors.secondary,
                onPressed: () => $navigate.to(AppRoutes.verifyPhrase),
                textColor: $styles.colors.white,
                text: $strings.continueTxt,
                padding: EdgeInsets.zero,
              ).marginSymmetric(horizontal: 16),
            ),
          ],
        ));
  }
}
