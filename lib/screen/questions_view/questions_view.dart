import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/view_model/questions_view/questions_view_model.dart' show QuestionsViewModel;

class QuestionsView extends StatelessWidget {
  const QuestionsView({Key? key}) : super(key: key);

  // routes.dart 内や pushNamed 時に参照されます。
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider を使って、 ViewModel を child の Widget で利用可能にする。
    return ChangeNotifierProvider<QuestionsViewModel>(
      create: (context) => QuestionsViewModel(),
      child: _QuestionsView(),
    );
  }
}

class _QuestionsView extends StatelessWidget {
  _QuestionsView({Key? key}) : super(key: key);

  // タイトルを表示する AppBar です。
  final appBar = AppBar(title: const Text('みろりおいる'));

  // ユーザへの指示を表示する Text です。
  final guideText = const Text('正直に回答していこう!');

  // NOTE: build は一度きり実行されるものではなく、何度も実行されるものであることを留意する。
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              guideText,
            ],
          ),
        ),
      ),
    );
  }
}
