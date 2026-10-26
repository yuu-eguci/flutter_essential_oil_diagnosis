import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_essential_oil_diagnosis/screen/questions_view/questions_view.dart';
import 'package:flutter_essential_oil_diagnosis/view_model/questions_view/questions_view_model.dart';

Question question(String text) =>
    Question(text: text, wetCold: true, dryCold: false, wetHot: false, dryHot: false);

void main() {
  testWidgets('問題数とスキップする問題数は質問データから出す', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: QuestionsView(questions: [question('A'), question('B'), question('C')]),
    ));

    expect(find.text('A'), findsOneWidget);
    expect(find.text('1 / 3'), findsOneWidget);
    expect(find.textContaining('2問'), findsOneWidget);

    await tester.tap(find.text('No'));
    await tester.pump();

    expect(find.text('B'), findsOneWidget);
    expect(find.text('2 / 3'), findsOneWidget);
    expect(find.textContaining('1問'), findsOneWidget);
  });
}
