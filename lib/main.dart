import 'package:to_do_app/app.dart';
import 'package:to_do_app/core/enums/env.dart';

Future<void> main() async {
  await initApp(env: Environment.prod);
}
