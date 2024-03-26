import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo/memo_domain.dart';
import 'package:memo/memo_list_provider.dart';
import 'package:provider/provider.dart';

class MemoCreateScreen extends StatefulWidget {
  @override
  _MemoCreateScreenState createState() => _MemoCreateScreenState();
}

class _MemoCreateScreenState extends State<MemoCreateScreen> {
  final TextEditingController titleController =
  TextEditingController(text: '名無しのタイトル');
  final TextEditingController contentController = TextEditingController();
  DateTime selectedDate = DateTime.now(); // 追加: 初期値を現在の日時に設定
  DateTime editDate = DateTime.now(); // 追加: 初期値を現在の日時に設定（とりあえず。）


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
              final String title = titleController.text;
              final String content = contentController.text;

              final memo = Memo(
                title: title,
                content: content,
                register_date: selectedDate,
                edited_date: editDate//// 選択された日時を使用
              );

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
            Row(
              children: [
                const Text(
                  '登録日時:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(context); // 日時選択ダイアログを表示
                    },
                    child: Text(
                      '${selectedDate.year}年${selectedDate.month}月${selectedDate.day}日',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: contentController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: '内容',
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // 日付選択ダイアログを表示するメソッド
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // 選択された日時を更新
      });
    }
  }
}
