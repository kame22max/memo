import 'package:flutter/material.dart';
import 'package:memo/memo_domain.dart';
import 'package:memo/memo_list_provider.dart';
import 'package:provider/provider.dart';

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
              maxLines: null,  // 複数行入力可能に設定
              keyboardType: TextInputType.multiline,  // キーボードのタイプを指定
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
