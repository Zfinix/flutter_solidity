import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoaderVM extends ChangeNotifier {
  final Reader read;

  LoaderVM(this.read);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  double? _percent;
  double? get percent => _percent;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  set percent(double? val) {
    _percent = val;
    notifyListeners();
  }

  /// Run Task and show loading
  void simulate(
    Function() callback, {
    Duration duration = const Duration(seconds: 2),
  }) async {
    /// Start Loading
    isLoading = true;

    /// Run delayed Task
    await Future.delayed(duration);

    /// End Loading
    isLoading = false;

    callback.call();
  }

  /// Run Task and show loading
  void runTask<T>(Future Function()? task) async {
    /// Load
    isLoading = true;

    /// Run async Task
    if (task != null) await task.call();

    /// Stop Loading
    isLoading = false;
  }
}
