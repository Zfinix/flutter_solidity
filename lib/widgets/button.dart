import 'package:flutter_solidity/core/extensions/extensions.dart';
import 'package:flutter_solidity/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_solidity/utils/colors.dart';
import 'package:flutter_solidity/widgets/touchable_opacity.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

enum FlSolidityButtonType { primary, white }

class FlSolidityButton extends StatelessWidget {
  const FlSolidityButton({
    Key? key,
    this.onTap,
    this.icon,
    this.width,
    this.height,
    this.padding,
    this.type = FlSolidityButtonType.primary,
    required this.text,
  }) : super(key: key);

  final FlSolidityButtonType? type;
  final VoidCallback? onTap;
  final double? width, height;
  final String text;
  final String? icon;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width ?? context.screenWidth(.87),
          height: height,
          child: TouchableOpacity(
            onTap: onTap,
            decoration: BoxDecoration(
              color: type == FlSolidityButtonType.white
                  ? Colors.transparent
                  : kFlSolidityGreen,
              border: type == FlSolidityButtonType.white
                  ? Border.all(color: kFlSolidityGrey100)
                  : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: padding ?? const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (icon != null && icon!.isNotEmpty)
                      SvgPicture.asset(
                        icon!.svg,
                        color: type == FlSolidityButtonType.white
                            ? kFlSolidityBlack
                            : white,
                      ).nudge(y: 1),
                    const Gap(5),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        color: type == FlSolidityButtonType.white
                            ? kFlSolidityBlack
                            : white,
                        fontWeight: FontWeight.w600,
                        fontFamily: kSkBold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FlSolidityWhiteButton extends StatelessWidget {
  const FlSolidityWhiteButton({
    Key? key,
    this.onTap,
    this.width,
    this.height,
    this.padding,
    required this.text,
  }) : super(key: key);

  final VoidCallback? onTap;
  final double? width, height;
  final String text;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.screenWidth(.2),
      height: height,
      child: TouchableOpacity(
        onTap: onTap,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 18),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: kFlSolidityBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
