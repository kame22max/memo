import 'package:flutter/material.dart';
import 'package:memo/memo_list_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoEditModel extends ChangeNotifier {


  final authorController = TextEditingController();



  String? title;
  String? text;

  void setTitle(String title){
    this.title = title;
    notifyListeners();
  }

  void setText(String text){
    this.text = text;
    notifyListeners();
  }

}

class MemoEditPage extends StatelessWidget {
  final int? index;
  MemoEditPage({this.index});


  @override
  Widget build(BuildContext context) {
    final memoListModel = Provider.of<MemoListModel>(context);
    final textController = TextEditingController();


    if (index != null) {
      textController.text = memoListModel.memos[index!].text;
    }

    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0.0,
          centerTitle: true,
          // backgroundColor: Colors.transparent,
          // elevation: 0,
          title: const Text(
            'メモタイトル ',
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
                    controller: textController,
                    decoration: const InputDecoration(hintText: '内容'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final text = textController.text;
                      if (index != null) {
                        memoListModel.editMemo(index!, Memo(text));
                      } else {
                        memoListModel.addMemo(Memo(text));
                      }
                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                  ),
                  if (index != null)
                    TextButton(
                      onPressed: () {
                        memoListModel.deleteMemo(index!);
                        Navigator.pop(context);
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
