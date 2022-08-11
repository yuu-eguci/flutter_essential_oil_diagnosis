import 'package:flutter/material.dart';

import '/screen/questions_view/questions_view.dart' show QuestionsView;
import '/screen/result_view/result_view.dart' show ResultView;

class RouteGenerator {
  RouteGenerator._();

  static Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case QuestionsView.routeName:
        return MaterialPageRoute(
          builder: (_) => const QuestionsView(),
        );
      case ResultView.routeName:
        return MaterialPageRoute(
          builder: (_) => const ResultView(),
        );
      default:
        throw const RouteException('Route not found');
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
