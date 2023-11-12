import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';


class Memo {
  int? id;
  String title;
  String content;

  Memo({this.id, required this.title, required this.content});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  factory Memo.fromMap(Map<String, dynamic> map) {
    return Memo(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}

class MemoDatabaseHelper {
  late Database _database;

  Future<void> initializeDatabase() async {
    final String path = join(await getDatabasesPath(), 'memos.db');

    _database = await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute(
      'CREATE TABLE memos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT)',
    );
  }

  Future<int> insertMemo(Memo memo) async {


    return await _database.insert('memos', memo.toMap());
  }

  Future<List<Memo>> getMemos() async {
    final List<Map<String, dynamic>> maps = await _database.query('memos');
    return List.generate(maps.length, (i) {
      return Memo.fromMap(maps[i]);
    });
  }

  Future<void> updateMemo(Memo memo) async {
    await _database.update(
      'memos',
      memo.toMap(),
      where: 'id = ?',
      whereArgs: [memo.id],
    );
  }

  Future<void> deleteMemo(int id) async {
    await _database.delete(
      'memos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllMemos() async {
    await _database.delete('memos');
  }


}



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
          content: Text('本当にすべてのメモを削除しますか？'),
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


class MemoCreateScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController(text: '名無しのタイトル');
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新しいメモを作成'),
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
                final String title = titleController.text;
                final String content = contentController.text;
                final memo = Memo(title: title, content: content);

                // Providerを使用して新しいメモを追加
                final memoListProvider = Provider.of<MemoListProvider>(context, listen: false);
                memoListProvider.addMemo(memo);

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
