import 'dart:math' show max;
import 'package:flutter/material.dart';

import '/view_model/questions_view/questions_view_model.dart' show Question;

class QuestionSum {
  /// 粘液。湿って冷たい。
  int wetCold = 0;

  /// 黒胆汁。乾いて冷たい。
  int dryCold = 0;

  /// 血液。湿って温かい。
  int wetHot = 0;

  /// 黄胆汁。乾いて温かい。
  int dryHot = 0;

  int get wetColdRate {
    return (wetCold / (wetCold + dryCold + wetHot + dryHot) * 100).round();
  }

  int get dryColdRate {
    return (dryCold / (wetCold + dryCold + wetHot + dryHot) * 100).round();
  }

  int get wetHotRate {
    return (wetHot / (wetCold + dryCold + wetHot + dryHot) * 100).round();
  }

  int get dryHotRate {
    return (dryHot / (wetCold + dryCold + wetHot + dryHot) * 100).round();
  }

  String get maxAttribute {
    int maxNumber = [wetCold, dryCold, wetHot, dryHot].reduce(max);
    if (maxNumber == wetCold) {
      return 'wetCold';
    } else if (maxNumber == dryCold) {
      return 'dryCold';
    } else if (maxNumber == wetHot) {
      return 'wetHot';
    } else {
      return 'dryHot';
    }
  }
}

class ResultViewModel extends ChangeNotifier {
  /// wetCold の割合。
  int wetCold = 0;

  /// dryCold の割合。
  int dryCold = 0;

  /// wetHot の割合。
  int wetHot = 0;

  /// dryHot の割合。
  int dryHot = 0;

  /// "あなたはこのタイプだ"
  String yourType = '';

  /// "あなたの特徴はコレだ"
  String yourCharacter = '';

  /// "おすすめの精油はコレだ"
  List<String> recommendedOils = [];

  void calculateResult(List<Question> questions) {
    // answer==true のものを集計します。
    final questionSum = QuestionSum();
    for (final Question question in questions.where((question) => question.answer)) {
      if (question.wetCold) {
        questionSum.wetCold++;
      }
      if (question.dryCold) {
        questionSum.dryCold++;
      }
      if (question.wetHot) {
        questionSum.wetHot++;
      }
      if (question.dryHot) {
        questionSum.dryHot++;
      }

      // それぞれの割合をセット。
      wetCold = questionSum.wetColdRate;
      dryCold = questionSum.dryColdRate;
      wetHot = questionSum.wetHotRate;
      dryHot = questionSum.dryHotRate;

      // "あなたはこのタイプだ"
      final Map<String, String> yourTypes = {
        'wetCold': '粘液・湿って冷たい',
        'dryCold': '黒胆汁・乾いて冷たい',
        'wetHot': '血液・湿って温かい',
        'dryHot': '黄胆汁・乾いて温かい',
      };
      yourType = yourTypes[questionSum.maxAttribute]!;

      // "あなたの特徴はコレだ"
      final Map<String, String> yourCharacters = {
        'wetCold': '背が低く丸顔。ゆっくりした印象。バランスの取れた性格で忍耐強い。物静かで内向的。仕事はまじめでコツコツとひとつずつ片付ける。習慣を返るのが苦手。責任を取るよりひとに従う。陸上競技会で喩えると、競技者に声援を送る観客。',
        'dryCold': '背が高く痩せ型。冷たく乾いた肌。直感的で感受性が強い。仕事は丁寧でまじめ。責任感が強い。計画上手ゆえ予定を変えることを嫌う。心配性で孤独を愛する。ときには鬱状態に陥る。陸上競技会で喩えると、マラソン走者。',
        'wetHot': '中背でがっしりとした厚みのある身体。血色がよくにこやか。満ち足りた印象を与える。優しく楽しく多弁な社交家。人の言うことはあまりきかない。誘惑に負けやすい。気分屋である。陸上競技会で喩えると、100m走者。',
        'dryHot': '背が高く骨格がしっかりしている。筋肉質でエネルギーに溢れた印象を与える。自分が上に立ってすべてを指揮する指導者タイプ。意思が強く行動的。愚痴を言わず努力する。短気で怒りっぽい面もある。陸上競技会で喩えると、10km走者。',
      };
      yourCharacter = yourCharacters[questionSum.maxAttribute]!;

      // "おすすめの精油はコレだ"
      final Map<String, List<String>> recommendedOilsList = {
        'wetCold': [  // 逆は 乾いて温かい
          'オレガノ',
          'オレンジ・スイート',
          'カモマイル・ジャーマン',
          'サイプレス',
          'ジュニパー',
          'ティートゥリー',
          'ネロリ',
          'バジル',
          'フランキンセンス',
          'ベルガモット',
          'マジョラム',
          'ユーカリ・ラディアタ',
          'ラベンダー・スピカ',
          'レモン',
          'ローズマリー・カンファー',
          'ローレル',
        ],
        'dryCold': [  // 逆は 湿って温かい
          'オレガノ',
          'クラリーセージ',
          'クローブ',
          'サンダルウッド',
          'シナモン・カッシア',
          'ジャスミン',
          'ゼラニウム',
          'ティートゥリー',
          'ネロリ',
          'パチュリー',
          'ペパーミント',
          'ホーウッド',
          'マジョラム',
          'ラベンダー・スピカ',
          'ローズ',
        ],
        'wetHot': [  // 逆は 乾いて冷たい
          'イランイラン',
          'カモマイル・ローマン',
          'クラリーセージ',
          'ジャスミン',
          'ゼラニウム',
          'ベルガモット',
        ],
        'dryHot': [  // 逆は 湿って冷たい
          'ペパーミント',
          'ユーカリ・ラディアタ',
          'ラベンダー・スピカ',
          'レモングラス',
          'ローズマリー・カンファー',
        ],
      };
      recommendedOils = recommendedOilsList[questionSum.maxAttribute]!;
    }
  }
}
