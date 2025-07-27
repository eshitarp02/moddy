import 'package:to_do_app/core/consts/cli_constants.dart';
import 'package:to_do_app/core/enums/env.dart';
import 'package:to_do_app/core/enums/uri_scheme.dart';
import 'package:to_do_app/core/utils/to_do_app_config.dart';

class AppConfig extends ToDoAppConfig {
  final UriScheme uriScheme;

  const AppConfig({
    required super.environment,
    required super.baseUrl,
    this.uriScheme = UriScheme.https,
  });

  static Future<AppConfig> init({required Environment env}) async {
    const baseUrlArg = String.fromEnvironment(CliConstants.baseUrl);
    const uriSchemeArg = String.fromEnvironment(CliConstants.uriScheme);

    return AppConfig(
      uriScheme: uriSchemeArg == UriScheme.http.name
          ? UriScheme.http
          : UriScheme.https,
      baseUrl: baseUrlArg,
      environment: env,
    );
  }
}
