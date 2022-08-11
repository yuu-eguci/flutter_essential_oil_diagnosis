import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screen/result_view/result_view.dart' show ResultView;
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
  final guideText = const Text('正直に回答していこう! 一度回答したら戻れないよ、適当に作ったからゴメンな!');

  // NOTE: build は一度きり実行されるものではなく、何度も実行されるものであることを留意する。
  @override
  Widget build(BuildContext context) {
    // ViewModel を監視します。
    final watch = context.watch<QuestionsViewModel>();

    // 質問文です。
    final questionTextCard = Card(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(watch.questions[watch.currentQuestionIndex].text),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.bottomRight,
            height: 50,
            child: Text('${watch.currentQuestionIndex + 1} / 50'),
          ),
        ],
      ),
    );

    // 回答用のボタンです。
    final yesButton = ElevatedButton(
      child: const Text('Yes'),
      onPressed: () {
        final read = context.read<QuestionsViewModel>();
        read.setAnswerYes();
        final moreQuestion = read.incrementQuestionIndex();
        if (!moreQuestion) {
          Navigator.of(context).pushReplacementNamed(
            ResultView.routeName,
            arguments: read.questions,
          );
          return;
        }
      },
    );
    final noButton = ElevatedButton(
      child: const Text('No'),
      onPressed: () {
        final read = context.read<QuestionsViewModel>();
        read.setAnswerNo();
        final moreQuestion = read.incrementQuestionIndex();
        if (!moreQuestion) {
          Navigator.of(context).pushReplacementNamed(
            ResultView.routeName,
            arguments: read.questions,
          );
          return;
        }
      },
    );
    final skipButton = ElevatedButton(
      child: const Text('アプリの動きを見たいだけだから49問てきとうに答えたことにしてよ'),
      onPressed: () {
        final read = context.read<QuestionsViewModel>();
        read.setRandomAnswers();
      },
    );

    final buttonRow = Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: yesButton,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: noButton,
            ),
          ),
        ),
      ],
    );
    final buttonRowSecond = Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: skipButton,
            ),
          ),
        ),
      ],
    );

    // 状態によっては、 widgets の有無をスイッチしたい。
    final children = <Widget>[
      guideText,
      questionTextCard,
      buttonRow,
    ];
    if (!watch.isLastQuestion()) {
      children.add(buttonRowSecond);
    }

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
