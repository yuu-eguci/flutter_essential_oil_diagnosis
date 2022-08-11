import 'package:flutter/material.dart';

class Question {
  Question({
    required this.text,
    required this.wetCold,
    required this.dryCold,
    required this.wetHot,
    required this.dryHot
  });

  /// 質問文。
  late final String text;

  /// 回答。
  bool answer = false;

  /// 粘液。湿って冷たい。
  late final bool wetCold;

  /// 黒胆汁。乾いて冷たい。
  late final bool dryCold;

  /// 血液。湿って温かい。
  late final bool wetHot;

  /// 黄胆汁。乾いて温かい。
  late final bool dryHot;
}

class QuestionsViewModel extends ChangeNotifier {
  QuestionsViewModel() {
    // 50の質問を初期化します。
    questions = [
      Question(text: '冬でもアイスクリームのような冷たいものが好き', wetCold: false, dryCold: false, wetHot: true, dryHot: true,),
      Question(text: '夏でも紅茶や珈琲はホットが好き', wetCold: true, dryCold: true, wetHot: false, dryHot: false,),
      Question(text: '汗がよく出る', wetCold: true, dryCold: false, wetHot: true, dryHot: false,),
      Question(text: '夏でも手のひらが乾き気味', wetCold: false, dryCold: true, wetHot: false, dryHot: true,),
      Question(text: '大勢の友達とワイワイやるのが好き', wetCold: true, dryCold: true, wetHot: false, dryHot: false,),
      Question(text: '人の不幸を黙って見ていられない', wetCold: false, dryCold: false, wetHot: true, dryHot: false,),
      Question(text: '他人に比較的無関心', wetCold: true, dryCold: false, wetHot: false, dryHot: false,),
      Question(text: '人と争うのが嫌いで最初から譲ってしまう', wetCold: true, dryCold: false, wetHot: false, dryHot: false,),
      Question(text: '競争が好き', wetCold: false, dryCold: true, wetHot: false, dryHot: false,),
      Question(text: '急にとても空腹になる', wetCold: false, dryCold: false, wetHot: true, dryHot: true,),
      Question(text: '食欲があったりなかったり一定しない', wetCold: false, dryCold: true, wetHot: false, dryHot: false,),
      Question(text: '尿や唾液の量が多い', wetCold: true, dryCold: false, wetHot: true, dryHot: false,),
      Question(text: '旅行に行く前にはきちっと計画を立てる', wetCold: false, dryCold: true, wetHot: false, dryHot: false,),
      Question(text: 'いきあたりばったりの旅が好き', wetCold: true, dryCold: false, wetHot: false, dryHot: false,),
      Question(text: '嫌いなことを後回しにする', wetCold: false, dryCold: false, wetHot: true, dryHot: false,),
      Question(text: 'クラス委員などになって活躍するのが好き', wetCold: false, dryCold: false, wetHot: true, dryHot: true,),
      Question(text: '物事を人任せにするのが嫌い', wetCold: false, dryCold: true, wetHot: false, dryHot: true,),
      Question(text: '几帳面できちんと片付けるほう', wetCold: false, dryCold: true, wetHot: false, dryHot: true,),
      Question(text: '部屋が散らかっている', wetCold: true, dryCold: false, wetHot: true, dryHot: false,),
      Question(text: '話す声が大きい', wetCold: false, dryCold: false, wetHot: true, dryHot: true,),
      Question(text: 'ぐっすりと深く眠る', wetCold: true, dryCold: false, wetHot: true, dryHot: false,),
      Question(text: '話を面白く脚色したり誇張したりする', wetCold: false, dryCold: false, wetHot: true, dryHot: false,),
      Question(text: '自己分析して自己嫌悪に陥ることがある', wetCold: false, dryCold: true, wetHot: false, dryHot: false,),
      Question(text: '素直な性格だと思う', wetCold: true, dryCold: false, wetHot: true, dryHot: false,),
      Question(text: '行動がゆっくりなので緩慢だとばかにされる', wetCold: true, dryCold: false, wetHot: false, dryHot: false,),
      Question(text: '取っ付きが悪いと言われる', wetCold: false, dryCold: true, wetHot: false, dryHot: false,),
      Question(text: '怒りっぽい', wetCold: false, dryCold: false, wetHot: false, dryHot: true,),
      Question(text: 'イライラしがち', wetCold: false, dryCold: true, wetHot: false, dryHot: true,),
      Question(text: '友達が多い', wetCold: true, dryCold: false, wetHot: true, dryHot: false,),
      Question(text: 'はっきりずけずけ言う', wetCold: false, dryCold: true, wetHot: false, dryHot: true,),
      Question(text: 'スポーツよりも本を読むのが好き', wetCold: true, dryCold: false, wetHot: false, dryHot: false,),
      Question(text: '物事を悲観的に考えがち', wetCold: false, dryCold: true, wetHot: false, dryHot: false,),
      Question(text: '楽観論者だ', wetCold: false, dryCold: false, wetHot: true, dryHot: true,),
      Question(text: '人を説得するのが得意', wetCold: false, dryCold: false, wetHot: true, dryHot: true,),
      Question(text: '慎重に考えて、すぐに結論を言わないことがある', wetCold: true, dryCold: false, wetHot: false, dryHot: false,),
      Question(text: 'あまり怒ったことがない', wetCold: true, dryCold: false, wetHot: false, dryHot: false,),
      Question(text: '与えられた仕事をきちんとこなす', wetCold: true, dryCold: true, wetHot: false, dryHot: true,),
      Question(text: '小細工を弄することがある', wetCold: false, dryCold: true, wetHot: false, dryHot: false,),
      Question(text: '理屈っぽい', wetCold: false, dryCold: true, wetHot: false, dryHot: true,),
      Question(text: '新しい環境でもすぐに友人を作れる', wetCold: true, dryCold: false, wetHot: true, dryHot: false,),
      Question(text: '人と衝突して嫌われることがよくある', wetCold: false, dryCold: false, wetHot: false, dryHot: true,),
      Question(text: 'ひょろっとした体型で、一見ひ弱な感じである', wetCold: false, dryCold: true, wetHot: false, dryHot: false,),
      Question(text: '太りやすい', wetCold: true, dryCold: false, wetHot: true, dryHot: false,),
      Question(text: 'がっちりした体型である', wetCold: false, dryCold: false, wetHot: true, dryHot: true,),
      Question(text: '怖い話は苦手で、怖がり屋だ', wetCold: true, dryCold: true, wetHot: false, dryHot: false,),
      Question(text: '買うものをしっかり決めて行くので衝動買いは少ない', wetCold: false, dryCold: true, wetHot: false, dryHot: true,),
      Question(text: '冒険が好き', wetCold: false, dryCold: false, wetHot: true, dryHot: true,),
      Question(text: '理想主義、完全主義に走ることがある', wetCold: false, dryCold: true, wetHot: false, dryHot: true,),
      Question(text: 'いやいやでも仕方なくやることが多い', wetCold: true, dryCold: false, wetHot: false, dryHot: false,),
      Question(text: '威張って感じが悪いと思われることがある', wetCold: false, dryCold: false, wetHot: false, dryHot: true,),
    ];
  }

  /// 質問の情報。
  late List<Question> questions;

  /// 現在の質問番号。
  int currentQuestionIndex = 0;


}
