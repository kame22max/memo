import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Memo {
  String title;
  String content;

  Memo({required this.title, required this.content});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }

  factory Memo.fromMap(Map<String, dynamic> map) {
    return Memo(
      title: map['title'],
      content: map['content'],
    );
  }

}

class MemoListProvider extends ChangeNotifier {
  List<Memo> memos = [];
  final String key = 'memos';

  MemoListProvider() {
    loadMemos();
  }

  Future<void> loadMemos() async {
    final prefs = await SharedPreferences.getInstance();
    final memosData = prefs.getStringList(key);

    if (memosData != null) {
      memos = memosData.map((memoJson) => Memo.fromMap(memoJson as Map<String, dynamic>)).toList();
      notifyListeners();
    }
  }

  Future<void> addMemo(Memo memo) async {
    memos.add(memo);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final memosData = memos.map((memo) => memo.toMap()).toList();
    prefs.setStringList(key, memosData.map((map) => map.toString()).toList());
  }

  Future<void> deleteMemo(int index) async {
    memos.removeAt(index);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final memosData = memos.map((memo) => memo.toMap()).toList();
    prefs.setStringList(key, memosData.map((map) => map.toString()).toList());
  }


  // void addMemo(Memo memo) {
  //   memos.add(memo);
  //   notifyListeners();
  // }
  //
  // void deleteMemo(int index) {
  //   memos.removeAt(index);
  //   notifyListeners();
  // }
}


class MemoCreateScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
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

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => MemoListProvider()),
//       ],
//       child: MaterialApp(
//         home: MemoCreateScreen(),
//       ),
//     ),
//   );
// }