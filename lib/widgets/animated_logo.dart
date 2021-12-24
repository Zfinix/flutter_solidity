import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_solidity/core/extensions/extensions.dart';

class FlSolidityAnimatedLogo extends StatefulWidget {
  const FlSolidityAnimatedLogo({
    Key? key,
    this.animate = true,
    this.size,
    this.color,
  }) : super(key: key);

  final bool animate;
  final double? size;
  final Color? color;

  @override
  State<StatefulWidget> createState() => _FlSolidityAnimatedLogo();
}

class _FlSolidityAnimatedLogo extends State<FlSolidityAnimatedLogo>
    with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFlSolidityAnimatedLogoOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );
    _fadeInFlSolidityAnimatedLogoOut =
        Tween<double>(begin: 0.0, end: 0.8).animate(animation);

    if (widget.animate) {
      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animation.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animation.forward();
        }
      });
    }
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _fadeInFlSolidityAnimatedLogoOut,
        child: SvgPicture.asset(
          'logo_white'.svg,
          color: widget.color,
          width: widget.size ?? 100,
        ),
      ),
    );
  }
}
