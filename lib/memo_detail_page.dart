import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        title: Text('メモ詳細'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog(context, memo.id!);
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
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: memo.content,
              // controller: contentController,
              maxLines: null, // nullを指定すると複数行入力が可能になります
              keyboardType: TextInputType.multiline, // キーボードのタイプを指定
              decoration: InputDecoration(labelText: '内容'),
              onChanged: (value){
                memo.content = value;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {

                _saveChanges(context, memo);
                // // メモを編集し、Providerを使用して更新
                // final updatedMemo = Memo(
                //
                //   title: titleController.text,
                //   content: contentController.text,
                // );
                // final memoListProvider = Provider.of<MemoListProvider>(context, listen: false);
                // await memoListProvider.updateMemo(updatedMemo);

              },
              child: Text('保存'),
            ),
            SizedBox(height: 2),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text('キャンセル'),
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
              final memoListProvider = Provider.of<MemoListProvider>(context, listen: false);
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