import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_solidity/core/extensions/extensions.dart';
import 'package:flutter_solidity/utils/colors.dart';
import 'package:flutter_solidity/utils/navigator.dart';
import 'package:flutter_solidity/widgets/touchable_opacity.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmptyAppBar({
    Key? key,
    this.color,
    this.title,
    this.backIcon,
    this.brightness,
    this.onBackPressed,
    this.hideBack = false,
  }) : super(key: key);

  final Color? color;
  final Brightness? brightness;
  final bool hideBack;
  final Widget? title;
  final String? backIcon;
  final VoidCallback? onBackPressed;

  bool get showBack => onBackPressed != null || title != null;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color ?? kBackground,
      shadowColor: Colors.transparent,
      // ignore: deprecated_member_use
      brightness: brightness ?? Brightness.light,
      elevation: 0,
      iconTheme: const IconThemeData(color: kFlSolidityBlack),
      title: title,
      leading: showBack && hideBack == false
          ? Container(
              padding: const EdgeInsets.all(20),
              child: TouchableOpacity(
                onTap: () {
                  navigator.popView();
                  onBackPressed!();
                },
                child: SvgPicture.asset(
                  (backIcon ?? 'back').svg,
                ),
              ),
            )
          : Container(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(showBack ? 58 : 0);
}
