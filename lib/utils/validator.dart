import 'package:intl/intl.dart';

String get ngn => '₦';

abstract class Validator {
  static NumberFormat get currency =>
      NumberFormat.currency(decimalDigits: 0, symbol: '$ngn ');

  static NumberFormat get noSymbolCurrency =>
      NumberFormat.currency(decimalDigits: 0, symbol: '');

  static bool isEmail(String em) {
    const p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  static bool longerThanSix(String em) {
    final hasMin6chars = em.length <= 6;
    return hasMin6chars == false;
  }

  static bool containSpecialChars(String em) {
    final _hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return !_hasSpecialCharacters.hasMatch(em);
  }

  static bool containsNumber(String em) {
    final _containsNumber = RegExp(r'[0-9]');
    return !_containsNumber.hasMatch(em);
  }
}
