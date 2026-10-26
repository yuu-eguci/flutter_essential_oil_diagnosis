import 'package:flutter/material.dart';

import '/screen/questions_view/questions_view.dart' show QuestionsView;
import '/screen/result_view/result_view.dart' show ResultView;
import '/view_model/questions_view/questions_view_model.dart' show Question;

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    // URL で直接開かれたときなどは回答がないので、最初の質問画面にします。
    if (settings.name == ResultView.routeName && arguments is List<Question>) {
      return MaterialPageRoute(
        builder: (_) => ResultView(questions: arguments),
        settings: settings,
      );
    }
    // QuestionsView と、知らないルートは最初の質問画面です。
    return MaterialPageRoute(
      builder: (_) => const QuestionsView(),
      settings: const RouteSettings(name: QuestionsView.routeName),
    );
  }
}
