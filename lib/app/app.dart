import 'package:flutter_solidity/core/providers.dart';
import 'package:flutter_solidity/utils/navigator.dart';
import 'package:flutter_solidity/views/home_page.dart';
import 'package:flutter_solidity/widgets/loading_wrapper.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_solidity/l10n/l10n.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: ProviderScopeApp(),
    );
  }
}

class ProviderScopeApp extends HookConsumerWidget {
  const ProviderScopeApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeVM)

      /// Force potrait mode on Android & iOS.
      ..handlePortraitMode();

    return AnnotatedRegion(
      value: theme.style,
      child: MaterialApp(
        title: 'Flutter Solidity',
        navigatorKey: navigator.key,
        debugShowCheckedModeBanner: false,
        theme: theme.themeData,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomePage(),
        navigatorObservers: [HeroController()],
        builder: (context, child) => Toast(
          navigatorKey: navigator.key,
          child: LoadingWrapper(child: child),
        ),
      ),
    );
  }
}
