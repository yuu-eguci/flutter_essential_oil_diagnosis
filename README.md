# flutter_essential_oil_diagnosis

Flutter + Dart で作った、お遊びの性格診断とアロマ精油選びアプリだよ。
山の日に、一日で作ってみようというノリで完成した。

https://user-images.githubusercontent.com/28250432/184184329-452fa6bd-02ea-426e-8e44-9b5b0727a2a4.mp4

- Flutter: 3.47.8 (stable) / Dart: 3.13.7
- Lint: `flutter analyze` (flutter_lints 6)
- テスト: `flutter test` (診断ロジック、ルーティング、画面遷移、配色のテスト)
- Docker: 対応! (analyze / test / Web ビルドのみ)
- CI: GitHub Actions で Docker (analyze / test / Web ビルド)、Android debug ビルド、iOS と macOS の署名なしビルド

## パッと実行してみたい

Flutter 3.47.8 を入れておく。

```bash
flutter pub get
flutter test
flutter run -d chrome
```

## Docker

Docker では analyze・test・Web ビルドを実行できる。
Android・iOS のビルドには各プラットフォームの環境が必要だよ。

```bash
# analyze と test
docker build --target check -t flutter-essential-oil-diagnosis-check .

# Web ビルドを build/web-docker に書き出す
docker build --target web --output type=local,dest=build/web-docker .
```

## 診断の仕様

- お遊びの性格診断で、医療や健康のアドバイスではない。
- Yes と答えた質問から 4 タイプ (粘液、黒胆汁、血液、黄胆汁) の割合を出して、いちばん多いタイプを表示する。
- 同点のときは 粘液 → 黒胆汁 → 血液 → 黄胆汁 の順で先にあるタイプになる。
- 全部 No のときは、タイプは判定できなかったと表示する。
- URL で結果画面を直接開いたときや、存在しないパスを開いたときは最初の質問画面を表示する。

## 対応プラットフォーム

| プラットフォーム | 状況 |
| --- | --- |
| Web | CI (Docker) でビルド。 Chrome で画面遷移を確認済み |
| Android | CI で debug ビルド |
| iOS | CI で署名なしビルド |
| macOS | CI で debug ビルド |
| Linux / Windows | ファイルはあるけど未確認 |

実機・Android emulator・iOS simulator での操作は未検証。
ストア申請・公開と署名設定の変更は行っていない。
