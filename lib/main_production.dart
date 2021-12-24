import 'dart:async';
import 'dart:developer';

import 'package:flutter_solidity/app/app.dart';
import 'package:flutter/widgets.dart';

void main() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(const App()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
