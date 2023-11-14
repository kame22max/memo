import 'package:flutter/material.dart';
import 'package:memo/memo_create_page.dart';
import 'package:memo/memo_detail_page.dart';
import 'package:memo/memo_list_provider.dart';
import 'package:memo/setting_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class MemoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final memoListProvider = Provider.of<MemoListProvider>(context);
    final memos = memoListProvider.memos;
    return Scaffold(
      appBar: AppBar(
        title: Text('メモ一覧'),
        leading: IconButton(icon: Icon(Icons.settings),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SettingPage(),
            ),
          );
        }


    ),

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
                _showDeleteConfirmationDialog(context, memo.id!);
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

