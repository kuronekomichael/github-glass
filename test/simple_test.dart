import 'package:flutter_test/flutter_test.dart';

void main() {
  test('RegExp sample', () {
    final String sampleDate = '2017-04-12';

    final RegExp dateRegex = new RegExp('^(\\d+)[-_/](\\d+)[-_/](\\d+)\$');

    Match matched = dateRegex.firstMatch(sampleDate);

    expect(matched != null, true);
  });
}
