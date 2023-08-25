import 'package:app_ui/theme/app_theme.dart';
import 'package:brapa/gen/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brapa/gen/injection/injection.dart';
import 'package:brapa/presentation/router/app_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'presentation/provider/language/setting_local_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initial Injection
  configureDependencies().then((value) {
    runApp(ProviderScope(child: InitialApp()));
  });
}

class InitialApp extends ConsumerWidget {
  InitialApp({super.key});

  final _appRouter = AppRouter(navigatorKey: getIt<GlobalKey<NavigatorState>>());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      final localeState = ref.watch(settingLocalProvider);

      return MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
        title: 'Brapa App',
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        locale: localeState,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      );
    });
  }
}
