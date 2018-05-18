import 'package:flutter_driver/driver_extension.dart';
import 'package:github_grass/main.dart' as app;

// flutter drive --target=test_driver/integration.dart --flavor Development
void main() {
  enableFlutterDriverExtension();
  app.main();
}
