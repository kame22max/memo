import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo/memo_database.dart';
import 'memo_domain.dart';

class MemoListProvider extends ChangeNotifier {
  List<Memo> memos = [];
  MemoDatabaseHelper _databaseHelper = MemoDatabaseHelper();

  MemoListProvider() {
    initializeProvider();
  }

  Future<void> initializeProvider() async {
    await _databaseHelper.initializeDatabase();
    loadMemos();
  }

  Future<void> loadMemos() async {
    final memos = await _databaseHelper.getMemos();
    this.memos = memos;
    notifyListeners();
  }

  Future<void> addMemo(Memo memo) async {
    await _databaseHelper.insertMemo(memo);
    loadMemos();
  }

  Future<void> updateMemo(Memo memo) async {
    await _databaseHelper.updateMemo(memo);
    loadMemos();
  }

  Future<void> deleteMemo(int id) async {
    await _databaseHelper.deleteMemo(id);
    loadMemos();
  }


  Future<void> deleteAllMemos() async {
    await _databaseHelper.deleteAllMemos();
    loadMemos();
  }



  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CupertinoAlertDialog(
          content: Text('すべてのメモを削除しますか？'),
          actions: <Widget>[
            TextButton(
              child: Text('はい'),
              onPressed: () {
                deleteAllMemos();
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

  Future<void> deleteAllMemosWithConfirmation(BuildContext context) async {
    await showDeleteConfirmationDialog(context);
  }

}
