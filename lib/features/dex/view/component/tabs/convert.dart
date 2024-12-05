import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/features/dex/controller/swap_controller.dart';
import 'package:sportRex/features/dex/view/component/custome_radio.dart';
import 'package:sportRex/features/dex/view/component/swap_box.dart';
import 'package:sportRex/shared/app_icons.dart';

class ConvertTab extends ConsumerStatefulWidget {
  const ConvertTab({Key? key}) : super(key: key);

  @override
  ConsumerState<ConvertTab> createState() => _ConvertTabState();
}

class _ConvertTabState extends ConsumerState<ConvertTab> {
  /// For test purpose--> (TODO:Please move to Controller)
  String? initialValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(20 * $styles.scale),
                    SwapBoxWidget(
                      controller: ref
                          .read(swapController.notifier)
                          .swapSourceController,
                      data: ref.watch(
                          swapController.select((value) => value.swapSource)),
                    ),
                    Gap(20 * $styles.scale),
                    SwapBoxWidget(
                      data: ref.watch(swapController
                          .select((value) => value.swapDestination)),
                      controller: ref
                          .read(swapController.notifier)
                          .swapDestinationController,
                    ),
                  ],
                ),
                SwapButton(
                  ref: ref,
                ),
              ],
            ),
            Gap(20 * $styles.scale),
            if (ref.watch(swapController.select((value) => value.isSwapBusy)))
              SizedBox(
                width: 100,
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation($styles.colors.secondary),
                  backgroundColor: $styles.colors.white,
                  minHeight: 1.5,
                ),
              ),

            Gap(30 * $styles.scale),

            ///Balance Selector
            CustomRadioGroup(
              options: const ["25%", "30%", "75%", "100%"],
              selectedOption: initialValue ?? "",
              activeColor: $styles.colors.secondary,
              inactiveColor: $styles.colors.greyMedium,
              onChanged: (String value) {
                setState(() {
                  initialValue = value;
                });
              },
            ),

            Gap(30 * $styles.scale),

            ///Convertion Price
            const ConvertionPrice(),

            Gap(60 * $styles.scale),

            AppBtn.from(
              bgColor: $styles.colors.secondary,
              canDisable: true,
              expand: true,
              onPressed: ref.watch(
                      swapController.select((value) => value.canApproveSwap))
                  ? () {}
                  : null,
              textColor: $styles.colors.white,
              text: "Approve",
            ),
            const Gap(300),
          ],
        ),
      ),
      isBusy: false,
    );
  }
}

class SwapButton extends StatelessWidget {
  final WidgetRef ref;
  const SwapButton({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 10,
        bottom: 0,
        right: 20,
        child: GestureDetector(
          onTap: () {
            ref.read(swapController.notifier).changeSwapPosition();
          },
          child: const AppIcon(
            AppIcons.swap,
            size: 50,
          ),
        ));
  }
}

class ConvertionPrice extends ConsumerWidget {
  const ConvertionPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
        ref.watch(
            swapController.select((value) => value.convertionMessage ?? "")),
        style: $styles.text.body.copyWith(
            color: $styles.colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600));
  }
}
