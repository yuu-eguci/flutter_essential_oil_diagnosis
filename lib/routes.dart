import 'package:flutter/material.dart';

import '/screen/questions_view/questions_view.dart' show QuestionsView;

class RouteGenerator {
  RouteGenerator._();

  static Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case QuestionsView.routeName:
        return MaterialPageRoute(
          builder: (_) => const QuestionsView(),
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
