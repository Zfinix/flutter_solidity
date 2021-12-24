import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'viewmodels/viewmodels.dart';

final themeVM = ChangeNotifierProvider((_) => ThemeVM());

final loaderVM = ChangeNotifierProvider((_) => LoaderVM(_.read));

final splashVM = ChangeNotifierProvider((_) => AppVM(_.read));
