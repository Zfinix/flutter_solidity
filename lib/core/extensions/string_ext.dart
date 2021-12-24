import 'package:encrypt/encrypt.dart' as crypt;
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

import 'package:flutter_solidity/utils/colors.dart';
import 'package:flutter_solidity/utils/navigator.dart';
import 'package:flutter_solidity/utils/validator.dart';

const _cryptKey = 'Sh7jLjxVdlihWHiFHhe5OQ==';
final iv = crypt.IV.fromLength(16);

extension StringExtensions on String {
  String get capitalize =>
      this[0].isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach =>
      split(' ').map((str) => str.capitalize).join(' ');

  String get svg => 'assets/images/svg/$this.svg';
  String get png => 'assets/images/png/$this.png';

  int get amountValue => int.parse(
        replaceAll('$ngn ', '').replaceAll(' ', '').replaceAll(',', ''),
      );

  String get encrypt {
    final encrypted = crypt.Encrypter(
      crypt.AES(
        crypt.Key.fromUtf8(_cryptKey),
      ),
    ).encrypt(this, iv: iv);

    return encrypted.base64;
  }

  String get decrypt {
    final decrypted = crypt.Encrypter(
      crypt.AES(
        crypt.Key.fromUtf8(_cryptKey),
      ),
    ).decrypt(
      crypt.Encrypted.fromBase64(this),
      iv: iv,
    );
    return decrypted;
  }

  void showSuccess({
    FlashPosition? position,
    Color? backgroundColor,
  }) async =>
      await showFlash(
        context: navigator.context,
        duration: const Duration(seconds: 3),
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: showFlashBar(
              text: this,
              controller: _,
              textColor: white,
              position: position,
              backgroundColor: backgroundColor ?? kFlSolidityGreen,
            ),
          );
        },
      );

  void showInfo({
    FlashPosition? position,
    Color? backgroundColor,
  }) async =>
      await showFlash(
        context: navigator.context,
        duration: const Duration(seconds: 3),
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: showFlashBar(
              text: this,
              controller: _,
              textColor: white,
              position: position,
              backgroundColor: backgroundColor ?? kFlSolidityBlack,
            ),
          );
        },
      );

  void showError({
    FlashPosition? position,
  }) async =>
      await showFlash(
        context: navigator.context,
        duration: const Duration(seconds: 3),
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: showFlashBar(
              text: '$this ⛔',
              controller: _,
              textColor: white,
              position: position,
              backgroundColor: kFlSolidityRed500,
            ),
          );
        },
      );
}

Flash<void> showFlashBar({
  required FlashController<dynamic> controller,
  required String text,
  Color? textColor,
  Color? backgroundColor,
  Curve? forwardAnimationCurve,
  Curve? reverseAnimationCurve,
  FlashPosition? position,
}) {
  return Flash.bar(
    controller: controller,
    position: position ?? FlashPosition.top,
    backgroundColor: backgroundColor ?? kFlSolidityBlack,
    horizontalDismissDirection: HorizontalDismissDirection.startToEnd,
    forwardAnimationCurve:
        forwardAnimationCurve ?? Curves.fastLinearToSlowEaseIn,
    reverseAnimationCurve: reverseAnimationCurve ?? Curves.fastOutSlowIn,
    margin: const EdgeInsets.symmetric(
      horizontal: 26,
      vertical: 14,
    ),
    borderRadius: BorderRadius.circular(12),
    child: FlashBar(
        content: Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: textColor ?? white,
          fontWeight: FontWeight.w500,
        ),
      ),
    )),
  );
}
