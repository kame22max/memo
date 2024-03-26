import 'package:memo/memo_domain.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MemoDatabaseHelper {
  late Database _database;

  Future<void> initializeDatabase() async {
    final String path = join(await getDatabasesPath(), 'memos.db');

    _database = await openDatabase(path, version: 2, onCreate: _createDatabase, onUpgrade: _upgradeDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute(
      'CREATE TABLE memos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, register_date TEXT)', // register_dateを追加
    );
  }

  // データベースのアップグレードロジック
  Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // バージョン1からバージョン2へのアップグレード時にregister_dateカラムを追加
      await db.execute('ALTER TABLE memos ADD COLUMN register_date TEXT');
    }
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
