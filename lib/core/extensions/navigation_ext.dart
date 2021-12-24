import 'package:flutter/material.dart';
import 'package:flutter_solidity/utils/navigator.dart';

extension MyNavigator on BuildContext {
  void navigateFromSplash(
    Widget route, {
    bool isDialog = false,
  }) =>
      navigator.navigateFromSplash(
        route,
        isDialog: isDialog,
      );

  void navigateReplace(
    Widget route, {
    bool isDialog = false,
    bool isTransparent = false,
  }) =>
      navigator.replaceTop(
        route,
        isDialog: isDialog,
        isTransparent: isTransparent,
      );

  void navigate(
    Widget route, {
    bool isDialog = false,
    bool isTransparent = false,
  }) =>
      navigator.pushTo(
        route,
        isDialog: isDialog,
        isTransparent: isTransparent,
      );

  void popToFirst() => navigator.popToFirst();

  void popView() => navigator.popView();

  bool get canPop => navigator.canPop;
}
