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
    final TextEditingController titleController = TextEditingController(text: memo.title);
    final TextEditingController contentController = TextEditingController(text: memo.content);

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
              controller: titleController,
              decoration: InputDecoration(labelText: 'タイトル'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: contentController,
              maxLines: null, // nullを指定すると複数行入力が可能になります
              keyboardType: TextInputType.multiline, // キーボードのタイプを指定
              decoration: InputDecoration(labelText: '内容'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // メモを編集し、Providerを使用して更新
                final updatedMemo = Memo(
                  title: titleController.text,
                  content: contentController.text,
                );
                final memoListProvider = Provider.of<MemoListProvider>(context, listen: false);
                await memoListProvider.updateMemo(updatedMemo);

                Navigator.pop(context);
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
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
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
