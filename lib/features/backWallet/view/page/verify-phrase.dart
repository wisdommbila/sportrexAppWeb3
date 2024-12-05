import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/features/backWallet/model/data/verify_seedPhrase_request.dart';
import 'package:sportRex/features/backWallet/view/component/chip-tiles.dart';
import 'package:sportRex/features/backWallet/view/component/verify-toast.dart';
import 'package:sportRex/features/secure/view/page/secure_wallet_pin_screen.dart';
import 'package:sportRex/shared/app_icons.dart';

import '../../../../core/commonLibs/common_libs.dart';
import '../../../../shared/base_background.dart';
import '../../controller/backup_pharse_controller.dart';

class VerifyPhrase extends ConsumerStatefulWidget {
  const VerifyPhrase({Key? key}) : super(key: key);

  @override
  ConsumerState<VerifyPhrase> createState() => _VerifyPhraseState();
}

class _VerifyPhraseState extends ConsumerState<VerifyPhrase> {
  List<String> selectedWords = [];

  late bool showError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(backupPharseController.notifier);
    return Skeleton(
        isBusy:
            ref.watch(backupPharseController.select((value) => value.isBusy)),
        bodyPadding: EdgeInsets.zero,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          textColor: $styles.colors.white,
          centerTitle: $strings.verifyPhrase,
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
                      $strings.verifyPhraseInfo,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.greyMedium,
                          fontSize: 14.8.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    Gap(20 * $styles.scale),
                    Text(
                      $strings.backUpPhrase,
                      style: $styles.text.body.copyWith(
                          color: $styles.colors.tertiary,
                          fontSize: 14.8.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    Gap(10 * $styles.scale),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: 100.0, minWidth: pageWidth(context)),
                      child: ChipTile(value: selectedWords),
                    ),
                    Gap(30 * $styles.scale),
                    if (showError && selectedWords.isNotEmpty)
                      VerifyToast(
                          icon: AppIcons.warning,
                          text: $strings.enteredInCorrectly,
                          backgroundColor: const Color(0xff9D6B6B)),
                    if (!showError && selectedWords.isNotEmpty)
                      VerifyToast(
                          icon: AppIcons.done,
                          text: $strings.enteredCorrectly,
                          backgroundColor: const Color(0xff698E6C)),
                    Gap(30 * $styles.scale),
                    Wrap(
                      spacing: 2,
                      children: controller.shuffledSeedPhrase.map((word) {
                        final isSelected = selectedWords.contains(word);
                        return ChoiceChip(
                          label: Text(word),
                          selected: isSelected,
                          selectedColor: $styles.colors.secondary,
                          selectedShadowColor: $styles.colors.greyMedium,
                          backgroundColor: $styles.colors.transparent,
                          shape: $styles.shapes.roundedShape,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedWords.add(word);

                                int index =
                                    selectedWords.indexOf(selectedWords.last);

                                if (controller.seedPhrase[index] != word) {
                                  showError = true;
                                }
                              } else {
                                selectedWords.remove(word);
                              }
                            });
                          },
                        );
                      }).toList(),
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
                onPressed: () => _submit(),
                textColor: $styles.colors.white,
                text: $strings.continueTxt,
                padding: EdgeInsets.zero,
              ).marginSymmetric(horizontal: 16),
            ),
          ],
        ));
  }

  _submit() async {
    final proceed = await ref
        .read(backupPharseController.notifier)
        .verifySeedPhrase(
            VerifySeedPhraseRequest(seedPhrase: selectedWords.join(" ")));
    if (proceed) {
      $navigate.to(SecureWalletPinScreen.route);
    }
  }
}
