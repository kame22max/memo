import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Memo {
  String title;
  String content;

  Memo({required this.title, required this.content});
}

class MemoListProvider extends ChangeNotifier {
  List<Memo> memos = [];

  void addMemo(Memo memo) {
    memos.add(memo);
    notifyListeners();
  }
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
