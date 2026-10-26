import 'package:flutter/material.dart';

import '/screen/questions_view/questions_view.dart' show QuestionsView;
import 'routes.dart' show RouteGenerator;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'みろりおいる',
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
      ),
      // NOTE: デバッグの際は、 initialRoute を変更できます。
      initialRoute: QuestionsView.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
      // Web で URL を直接開かれたときも、そのパスの画面ひとつだけで始めます。
      onGenerateInitialRoutes: (initialRoute) => [
        RouteGenerator.generateRoute(RouteSettings(name: initialRoute)),
      ],
    );
  }
}
