import 'package:flutter/material.dart';
import 'package:memo/domain.dart';
import 'package:memo/memo_edit_page.dart';
import 'package:memo/memo_list_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Memo {
  Memo(
    this.text,
  );

  String text;
}

class MemoListModel extends ChangeNotifier {
  List<Memo> _memos = [];

  List<Memo> get memos => _memos;

  void addMemo(Memo memo) {
    _memos.add(memo);
    notifyListeners();
  }

  void editMemo(int index, Memo updatedMemo) {
    _memos[index] = updatedMemo;
    notifyListeners();
  }

  void deleteMemo(int index) {
    _memos.removeAt(index);
    notifyListeners();
  }
}

class MemoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final memoListModel = Provider.of<MemoListModel>(context);
    final memos = memoListModel.memos;
    return ChangeNotifierProvider(
        create: (_) => MemoListModel(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(0.0),
            elevation: 0.0,
            actions: <Widget>[
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    '編集',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                    ),
                  )),
            ],
          ),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Row(
                  children: <Widget>[
                    SizedBox(width: 16,),
                    Text(
                      'メモ一覧',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: memos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MemoEditPage(index: index),
                            ),
                          );
                        },
                        onLongPress: () {},
                        title: Text('test'),
                      );
                    },
                  ),
                ),
              ]),
          floatingActionButton: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemoEditPage(),
                    ),
                  );
                },
                label: Text("新規作成"),
              ),
            );
          }),
        ));
  }
}
