import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
//import 'package:path_provider/path_provider.dart';

void main() {
  group('Sample integration test', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) await driver.close();
    });

    test('Input and confirm', () async {
      SerializableFinder button = find.byType('FloatingActionButton');

      await driver.screenshot();

      await driver.tap(button);

      await driver.screenshot();
    });
  });
}
