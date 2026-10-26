import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screen/questions_view/questions_view.dart' show QuestionsView;
import '/view_model/questions_view/questions_view_model.dart' show Question;
import '/view_model/result_view/result_view_model.dart' show ResultViewModel;

class ResultView extends StatelessWidget {
  const ResultView({super.key, required this.questions});

  // routes.dart 内や pushNamed 時に参照されます。
  static const routeName = '/ResultView';

  /// 前の画面で回答した質問です。 routes.dart で引数から受け取ります。
  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    // List<Question> を集計した ViewModel を、 ChangeNotifierProvider を使って child の Widget で利用できるようにします。
    return ChangeNotifierProvider<ResultViewModel>(
      create: (context) => ResultViewModel()..calculateResult(questions),
      child: _ResultView(),
    );
  }
}

class _ResultView extends StatelessWidget {
  _ResultView();

  // タイトルを表示する AppBar です。
  final appBar = AppBar(title: const Text('みろりおいる'));

  // NOTE: build は一度きり実行されるものではなく、何度も実行される点に注意します。
  @override
  Widget build(BuildContext context) {
    // ViewModel を監視します。
    final watch = context.watch<ResultViewModel>();

    // "あなたはこのタイプだ"
    final yourTypeText = Text('あなたは ${watch.yourType} タイプだ。');
    final wetColdRateText = Text('粘液・湿って冷たい: ${watch.wetCold}%');
    final dryColdRateText = Text('黒胆汁・乾いて冷たい: ${watch.dryCold}%');
    final wetHotRateText = Text('血液・湿って温かい: ${watch.wetHot}%');
    final dryHotRateText = Text('黄胆汁・乾いて温かい: ${watch.dryHot}%');

    // "あなたの特徴はコレだ"
    final yourCharacterCard = Card(
      child: SizedBox(
        height: 150,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('特徴: ${watch.yourCharacter}'),
          ),
        ),
      ),
    );

    // "おすすめの精油はコレだ"
    const recommendedDescription = Text('選ぶべきは、自分のタイプとは逆のタイプの精油なので……このへん。');
    final List<Text> oilTexts = watch.recommendedOils.map((String oilName) => Text(oilName)).toList();
    final recommendedOilCard = Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: oilTexts,
        ),
      ),
    );

    // 最初に戻るボタンです。
    final backToStartButton = ElevatedButton(
      child: const Text('Back to start'),
      onPressed: () {
        Navigator.of(context).popAndPushNamed(QuestionsView.routeName);
      },
    );

    // Yes の回答がひとつもなくて、タイプを判定できなかったときです。
    const undeterminedText = Text('Yes と答えた質問がなかったので、タイプは判定できなかったよ。もう一回やってみてね。');

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: watch.isDetermined
                ? <Widget>[
                    yourTypeText,
                    wetColdRateText,
                    dryColdRateText,
                    wetHotRateText,
                    dryHotRateText,
                    yourCharacterCard,
                    recommendedDescription,
                    recommendedOilCard,
                    backToStartButton,
                  ]
                : <Widget>[
                    undeterminedText,
                    backToStartButton,
                  ],
          ),
        ),
      ),
    );
  }
}
