import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppBlocObserver extends BlocObserver {
  final log = Logger();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log.d('blocOnChange');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log.d('blocOnEvent');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log.d('blocOnError');
    log.e('Error: $error'); // Log error message
    log.e('StackTrace: $stackTrace'); // Log stack trace separately
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log.d('blocOnCreate');
  }
}
