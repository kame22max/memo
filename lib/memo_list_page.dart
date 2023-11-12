import 'package:flutter/material.dart';
import 'package:memo/add_memo_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memo/domain.dart';
import 'package:memo/memo_edit_page.dart';
import 'package:memo/memo_list_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cupertino_icons/cupertino_icons.dart';


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
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await memoListProvider.deleteAllMemosWithConfirmation(context);
              //画面遷移
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: memos.length,
        itemBuilder: (context, index) {
          final memo = memos[index];
          return Card(
            child: ListTile(
              title: Text(memo.title),
              subtitle: Text(memo.content),
              onTap: () {
                // メモの詳細ページに遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MemoDetailScreen(memo: memo, index: index),
                  ),
                );
              },
              onLongPress: () {
                _showDeleteDialog(context, index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MemoCreateScreen()));
        },
        label: Text('新規作成'), //テキスト
        icon: Icon(Icons.add), //アイコン
      ),
    );
  }
}

class MemoDetailScreen extends StatelessWidget {
  final Memo memo;
  final int index;

  MemoDetailScreen({required this.memo, required this.index});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(text: memo.title);
    final TextEditingController contentController = TextEditingController(text: memo.content);

    return Scaffold(
      appBar: AppBar(
        title: Text('メモ詳細'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showDeleteDialog(context, index);
              //画面遷移
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'タイトル'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: contentController,
              maxLines: 5,
              decoration: InputDecoration(labelText: '内容'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // メモを編集し、Providerを使用して更新
                final updatedMemo = Memo(
                  title: titleController.text,
                  content: contentController.text,
                );
                final memoListProvider = Provider.of<MemoListProvider>(context, listen: false);
                memoListProvider.memos[index] = updatedMemo;
                Navigator.pop(context);
              },
              child: Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}

void _showDeleteDialog(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('メモを削除しますか？'),
        actions: <Widget>[
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              final memoListProvider =
                  Provider.of<MemoListProvider>(context, listen: false);
              memoListProvider.deleteMemo(index);
              Navigator.of(dialogContext).pop(); // ダイアログを閉じる
            },
          ),
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // ダイアログを閉じる
            },
          ),
        ],
      );
    },
  );
}
