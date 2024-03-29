import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo/memo_domain.dart';
import 'package:memo/memo_list_provider.dart';
import 'package:provider/provider.dart';

class MemoDetailScreen extends StatelessWidget {
  final Memo memo;
  final int index;

  MemoDetailScreen({required this.memo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pinkAccent,

            title: Text('メモ編集'),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _showDeleteConfirmationDialog(context, memo.id!);
                  //画面遷移
                },
              ),
              IconButton(
                icon: const Icon(Icons.done),
                onPressed: () {
                  _saveChanges(context, memo);

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
                  initialValue: memo.title,
                  // controller: titleController,
                  decoration: InputDecoration(labelText: 'タイトル'),
                  onChanged: (value) {
                    memo.title = value;
                    memo.edited_date = DateTime.now(); // 編集日付を更新

                  },
                ),
                SizedBox(height: 16),

                TextFormField(
                  initialValue: memo.content,
                  // controller: contentController,
                  maxLines: null,
                  // nullを指定すると複数行入力が可能になります
                  keyboardType: TextInputType.multiline,
                  // キーボードのタイプを指定
                  decoration: InputDecoration(labelText: '内容',border: InputBorder.none,),
                  onChanged: (value) {
                    memo.content = value;
                    memo.edited_date = DateTime.now(); // 編集日付を更新

                  },
                ),

              ],
            ),
          ),
        );
  }
}




void _showDeleteConfirmationDialog(BuildContext context, int memoId) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return CupertinoAlertDialog(
        title: Text('メモを削除しますか？'),
        actions: <Widget>[
          TextButton(
            child: Text('はい'),
            onPressed: () {
              final memoListProvider =
                  Provider.of<MemoListProvider>(context, listen: false);
              memoListProvider.deleteMemo(memoId);
              Navigator.of(dialogContext).pop(); // ダイアログを閉じる
              Navigator.pop(context); // メモ詳細画面を閉じる
            },
          ),
          TextButton(
            child: Text('いいえ'),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // ダイアログを閉じる
            },
          ),
        ],
      );
    },
  );
}


void _saveChanges(BuildContext context, Memo memo) {
  // Use MemoListProvider to update the memo
  var memoListProvider = Provider.of<MemoListProvider>(context, listen: false);
  memoListProvider.updateMemo(memo);
  _showSaveConfirmationDialog(context);
  // Navigate back to MemoDetailScreen
}

void _showSaveConfirmationDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('保存しました。'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
