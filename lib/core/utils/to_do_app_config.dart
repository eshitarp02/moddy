import 'package:to_do_app/core/enums/env.dart';

class ToDoAppConfig {
  final String baseUrl;
  final Environment environment;

  const ToDoAppConfig({
    required this.baseUrl,
    required this.environment,
  });
}
