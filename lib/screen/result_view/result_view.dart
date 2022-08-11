import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/view_model/result_view/result_view_model.dart' show ResultViewModel;

class ResultView extends StatelessWidget {
  const ResultView({Key? key}) : super(key: key);

  // routes.dart 内や pushNamed 時に参照されます。
  static const routeName = '/ResultView';

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider を使って、 ViewModel を child の Widget で利用可能にする。
    return ChangeNotifierProvider<ResultViewModel>(
      create: (context) => ResultViewModel(),
      child: _ResultView(),
    );
  }
}

class _ResultView extends StatelessWidget {
  _ResultView({Key? key}) : super(key: key);

  // タイトルを表示する AppBar です。
  final appBar = AppBar(title: const Text('みろりおいる'));

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
            ],
          ),
        ),
      ),
    );
  }
}
