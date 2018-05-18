import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_grass/widgets/parts.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    bool current = false;

    // テスト対象のWidget
    Widget widget = new MyFlipButton(
        aText: 'オモテ',
        bText: 'ウラ',
        onPressed: () {
          current = true;
        });
    await tester.pumpWidget(new MaterialApp(home: widget));

    // 初期状態は'オモテ'を向いている
    expect(current, isFalse);
    expect(find.text('オモテ'), findsOneWidget);
    expect(find.text('ウラ'), findsNothing); // 'ウラ'が存在しないことを確認

    // FlipButtonをタップ
    await tester.tap(find.byType(MyFlipButton));
    // フレームを先に進める
    await tester.pump();

    // 状態が'ウラ'に変わっていることを確認
    expect(current, isTrue);
    expect(find.text('オモテ'), findsNothing);
    expect(find.text('ウラ'), findsOneWidget); // 'オモテ'が存在しないことを確認
  });
}
