import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_essential_oil_diagnosis/view_model/questions_view/questions_view_model.dart';
import 'package:flutter_essential_oil_diagnosis/view_model/result_view/result_view_model.dart';

/// [yesTexts] の質問だけ Yes と答えた質問リストを返します。
List<Question> answer(Set<String> yesTexts) {
  final questions = QuestionsViewModel().questions;
  for (final question in questions) {
    question.answer = yesTexts.contains(question.text);
  }
  return questions;
}

void main() {
  test('Yes と答えた質問から割合とタイプを出す', () {
    final viewModel = ResultViewModel()..calculateResult(answer({'怒りっぽい'}));

    expect(viewModel.dryHot, 100);
    expect(viewModel.wetCold + viewModel.dryCold + viewModel.wetHot, 0);
    expect(viewModel.yourType, '黄胆汁・乾いて温かい');
    expect(viewModel.recommendedOils, contains('レモングラス'));
  });

  test('同点のときは 粘液 → 黒胆汁 → 血液 → 黄胆汁 の順で先にあるタイプになる', () {
    // 粘液だけの質問と黄胆汁だけの質問に Yes で、1 対 1 の同点。
    final viewModel = ResultViewModel()
      ..calculateResult(answer({'他人に比較的無関心', '怒りっぽい'}));

    expect(viewModel.wetCold, 50);
    expect(viewModel.dryHot, 50);
    expect(viewModel.yourType, '粘液・湿って冷たい');
  });

  test('全部 No だとタイプは判定しない', () {
    final viewModel = ResultViewModel()..calculateResult(answer({}));

    expect(viewModel.isDetermined, isFalse);
    expect(viewModel.yourType, isEmpty);
    expect(viewModel.yourCharacter, isEmpty);
    expect(viewModel.recommendedOils, isEmpty);
  });
}
