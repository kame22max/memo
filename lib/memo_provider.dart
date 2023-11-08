// import 'package:memo/memo_list_page.dart';
// import 'package:riverpod/riverpod.dart';
//
// class Memo {
//   String title;
//   String body;
//
//   Memo(
//       this.title,
//       this.body,
//       );
//
//
// }
//
//
// final memoProvider = StateNotifierProvider<MemoNotifier, List<String>>((ref) {
//   return MemoNotifier(); // MemoNotifierはあなたのメモデータの状態を管理するカスタムクラスです。
// });
//
//
// final memoListProvider = Provider<List<Memo>>((ref) {
//   // メモデータをここで取得または生成
//   return [
//     Memo(title: 'メモ1', body: 'メモの本文1'),
//     Memo(title: 'メモ2', body: 'メモの本文2'),
//     // 他のメモを追加
//   ];
// });
