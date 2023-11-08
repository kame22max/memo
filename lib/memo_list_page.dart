import 'package:flutter/material.dart';
import 'package:memo/add_memo_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memo/domain.dart';
import 'package:memo/memo_edit_page.dart';
import 'package:memo/memo_list_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


// class Memo {
//   String title;
//   String content;
//   DateTime createdTime;
//
//   Memo({
//     required this.title,
//     required this.content,
//     required this.createdTime,
//   });
//
//   // メモオブジェクトをMapに変換するメソッド
//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'content': content,
//       'createdTime': createdTime.toIso8601String(),
//     };
//   }
//
//   // Mapからメモオブジェクトを作成するファクトリメソッド
//   factory Memo.fromMap(Map<String, dynamic> map) {
//     return Memo(
//       title: map['title'],
//       content: map['content'],
//       createdTime: DateTime.parse(map['createdTime']),
//     );
//   }
// }

class MemoListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final memoListProvider = Provider.of<MemoListProvider>(context);
    final memos = memoListProvider.memos;
    return Scaffold(
      appBar: AppBar(
        title: Text('メモ一覧'),
      ),
      body: ListView.builder(
        itemCount: memos.length,
        itemBuilder: (context, index) {
          final memo = memos[index];
          return ListTile(
            title: Text(memo.title),
            subtitle: Text(memo.content),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MemoCreateScreen()));


        },
        label: Text('Add'), //テキスト
        icon: Icon(Icons.add), //アイコン
      ),
    );
  }
}
