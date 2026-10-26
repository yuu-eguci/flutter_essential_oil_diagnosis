import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_essential_oil_diagnosis/main.dart';

const firstQuestion = '冬でもアイスクリームのような冷たいものが好き';
const secondQuestion = '夏でも紅茶や珈琲はホットが好き';

Future<void> tapAndSettle(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('最初の質問から始まり、Yes で次の質問に進む', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text(firstQuestion), findsOneWidget);
    expect(find.text('1 / 50'), findsOneWidget);
    expect(find.textContaining('49問'), findsOneWidget);

    await tapAndSettle(tester, find.text('Yes'));

    expect(find.text(secondQuestion), findsOneWidget);
    expect(find.text('2 / 50'), findsOneWidget);
    // 残りは 48 問なので、スキップボタンの問題数も減る。
    expect(find.textContaining('48問'), findsOneWidget);
  });

  testWidgets('スキップして最後の質問に答えると結果が出て、最初に戻れる', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tapAndSettle(tester, find.textContaining('問てきとうに'));

    expect(find.text('50 / 50'), findsOneWidget);
    // 最後の質問ではスキップボタンは出さない。
    expect(find.textContaining('問てきとうに'), findsNothing);

    await tapAndSettle(tester, find.text('Yes'));

    // 最後の質問に Yes と答えているので、タイプは必ず判定できる。
    expect(find.textContaining('あなたは '), findsOneWidget);
    expect(find.textContaining('特徴: '), findsOneWidget);

    await tapAndSettle(tester, find.text('Back to start'));

    expect(find.text(firstQuestion), findsOneWidget);
    expect(find.text('1 / 50'), findsOneWidget);
  });

  testWidgets('全部 No だとタイプは判定できなかったと表示する', (tester) async {
    await tester.pumpWidget(const MyApp());

    for (var i = 0; i < 50; i++) {
      await tapAndSettle(tester, find.text('No'));
    }

    expect(find.textContaining('判定できなかった'), findsOneWidget);
    expect(find.textContaining('あなたは '), findsNothing);
    expect(find.textContaining('特徴: '), findsNothing);
    expect(find.text('Back to start'), findsOneWidget);
  });

  group('URL で直接開いたとき', () {
    for (final path in ['/ResultView', '/does-not-exist']) {
      testWidgets('$path は最初の質問画面になる', (tester) async {
        tester.platformDispatcher.defaultRouteNameTestValue = path;
        addTearDown(tester.platformDispatcher.clearDefaultRouteNameTestValue);

        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();

        expect(find.text(firstQuestion), findsOneWidget);
        expect(find.text('1 / 50'), findsOneWidget);
        // 質問画面が重なって戻るボタンが表示されないことを確認します。
        expect(find.byType(BackButton), findsNothing);
      });
    }
  });
}
