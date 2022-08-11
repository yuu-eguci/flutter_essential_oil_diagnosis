import 'package:flutter/material.dart';

import '/screen/questions_view/questions_view.dart' show QuestionsView;
import 'routes.dart' show RouteGenerator;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'みろりおいる',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
      ),
      // NOTE: デバッグの際は、 initialRoute を変更するとよい。
      initialRoute: QuestionsView.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
