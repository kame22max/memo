import 'package:flutter/material.dart';
import 'package:memo/memo_create_page.dart';
import 'package:memo/memo_detail_page.dart';
import 'package:memo/memo_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class MemoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final memoListProvider = Provider.of<MemoListProvider>(context);
    final memos = memoListProvider.memos;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('メモリスト'),
        // テキストの色を自動的に反転
        leading: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {

              await memoListProvider.deleteAllMemosWithConfirmation(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SettingPage(),
              //   ),
              // ); //画面遷移
            }),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MemoCreateScreen(),
                ),
              ); //画面遷移
            },
          ),
        ],

      ),
      body: ListView.builder(
        itemCount: memos.length,
        itemBuilder: (context, index) {
          final memo = memos[index];
          // 仮のメモの内容
          String memoContent = memo.content;

          // メモの内容を10文字までに制限
          String truncatedContent = memoContent.length > 10
              ? '${memoContent.substring(0, 10)}...'
              : memoContent;

          return SizedBox(
            height: 150,
            child: Card(
              child: ListTile(
                title: Text(memo.title),
                subtitle: Text(truncatedContent),
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
            ),
          );
        },
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
                // メモを削除した後にSnackBarを表示
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('メモを削除しました。'),
                    action: SnackBarAction(
                      label: '元に戻す',
                      onPressed: () {},
                    ),
                  ),
                );
              }),
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
