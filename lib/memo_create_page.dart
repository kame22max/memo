import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo/memo_database.dart';
import 'package:memo/memo_domain.dart';
import 'package:memo/memo_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class MemoCreateScreen extends StatelessWidget {
  final TextEditingController titleController =
      TextEditingController(text: '名無しのタイトル');
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,

        title: Text('新規作成'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () async {
              final DateTime createAt = DateTime.now();
              final String title = titleController.text;
              final String content = contentController.text;

              final memo = Memo(title: title, content: content, );

              // Providerを使用して新しいメモを追加
              final memoListProvider =
                  Provider.of<MemoListProvider>(context, listen: false);
              memoListProvider.addMemo(memo);

              Navigator.pop(context);
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
              maxLines: null, // 複数行入力可能に設定
              keyboardType: TextInputType.multiline, // キーボードのタイプを指定
              decoration: InputDecoration(
                labelText: '内容', border: InputBorder.none, // 下線をなくす
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

}
