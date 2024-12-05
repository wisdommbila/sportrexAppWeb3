import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/features/card/view/component/card/back.dart';
import 'package:sportRex/features/card/view/component/card/front.dart';

class FlipDebitCard extends StatefulWidget {
  final Color? color;
  final VoidCallback? onPressed;
  const FlipDebitCard({Key? key, this.color, this.onPressed}) : super(key: key);

  @override
  State<FlipDebitCard> createState() => _FlipDebitCardState();
}

class _FlipDebitCardState extends State<FlipDebitCard> {
  late bool _showFrontSide;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _switchCard,
      onTap: () {
        widget.onPressed?.call();
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child: _showFrontSide
            ? CardFront(
                color: widget.color,
              )
            : BackCard(color: widget.color),
      ),
    );
  }

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}
