import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/blocs/app_bloc_observer.dart';
import 'package:to_do_app/blocs/app_settings/app_settings_bloc.dart';
import 'package:to_do_app/core/consts/app_constants.dart';
import 'package:to_do_app/core/enums/env.dart';
import 'package:to_do_app/core/theme/theme.dart';
import 'package:to_do_app/core/utils/injector.dart';
import 'package:to_do_app/routes/routes.dart';
import 'package:toastification/toastification.dart';

Future<void> initApp({Environment env = Environment.prod}) async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Workaround for enabling landscape orientations in `Info.plist`
  ///
  /// Programmatically force portrait until told otherwise (eg. within video player)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Bloc.observer = AppBlocObserver();
  await Injector.init(
    env: env,
    appRunner: () => runApp(AppWrapper(env: env)),
  );
}

class AppWrapper extends StatelessWidget {
  final Environment env;
  const AppWrapper({required this.env, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppSettingsBloc()..add(const AppSettingsOnLoadEvent()),
      child: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, state) {
        if (state is AppSettingsOnLoadState) {
          return ToastificationWrapper(
            child: MaterialApp.router(
              key: ObjectKey(state),
              debugShowCheckedModeBanner: false,
              title: AppConstants.appName,
              theme: AppTheme.lightTheme(),
              routerConfig: router,
              themeMode: state.themeMode,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child ?? const SizedBox.shrink(),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
