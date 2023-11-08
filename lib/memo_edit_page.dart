import 'package:flutter/material.dart';
import 'package:memo/memo_list_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoEditModel extends ChangeNotifier {

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  String? title;
  String? content;



}

class MemoEditPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0.0,
          centerTitle: true,
          // backgroundColor: Colors.transparent,
          // elevation: 0,
          title: const Text(
            '新規作成 ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 16,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),

        body:Center(
              child: Column(
                children: [
                  TextField(

                    decoration: const InputDecoration(
                        border: InputBorder.none, // 下線を非表示
                        hintText: '内容'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      // final text = textController.text;
                      // if (index != null) {
                      //   memoListModel.editMemo(index!, Memo(text));
                      // } else {
                      //   memoListModel.addMemo(Memo(text));
                      // }
                      // Navigator.pop(context);
                    },
                    child: Text('Save'),
                  ),

                    TextButton(
                      onPressed: () {
                        // memoListModel.deleteMemo(index!);
                        // Navigator.pop(context);
                      },
                      child: Text('Delete'),
                    ),

                ],
              ),

        ),
      );
    });
  }
}
