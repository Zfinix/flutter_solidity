import 'dart:io';

import 'package:flutter_solidity/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_solidity/utils/colors.dart';

class ThemeVM extends ChangeNotifier {
  /// Instance of ThemeVM

  Color _systemNavigationBarColor = black;
  Color get systemNavigationBarColor => _systemNavigationBarColor;
  set systemNavigationBarColor(Color val) {
    _systemNavigationBarColor = val;
    notifyListeners();
  }

  /// Toggle Bottom Nav bar color between white and green
  void toggleBottomNavColor() {
    _systemNavigationBarColor = _systemNavigationBarColor == kBackground
        ? kFlSolidityBlack
        : kBackground;
    notifyListeners();
  }

  /// App's Theme data
  ThemeData get themeData => ThemeData(
        primaryColor: kFlSolidityBlack,
        fontFamily: kSkRegular,
        backgroundColor: kBackground,
        appBarTheme: const AppBarTheme(
          color: kFlSolidityGreen,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: kFlSolidityGreen,
        ),
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: kFlSolidityBlack,
            selectionHandleColor: kFlSolidityBlack,
            selectionColor: kFlSolidityBlack.withOpacity(0.1)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  /// Force potriat mode for app
  void handlePortraitMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// System overlay style
  SystemUiOverlayStyle get style => SystemUiOverlayStyle(
        /* set Status bar color in Android devices. */
        statusBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        /* set Status bar icons color in Android devices.*/
        statusBarIconBrightness:
            (Platform.isIOS ? Brightness.light : Brightness.dark),
        /* set Status bar icon color in iOS. */
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
}
