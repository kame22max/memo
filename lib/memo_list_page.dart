import 'package:flutter/material.dart';
import 'package:memo/domain.dart';
import 'package:memo/memo_edit_page.dart';
import 'package:memo/memo_list_model.dart';
import 'package:provider/provider.dart';

// class Memo{
//   Memo(this.content);
//   String content;
//
// }


class MemoListModel extends ChangeNotifier {

  List<int> memos = [];

  void addItem(int memo) {
    memos.add(memo);
    notifyListeners();
  }


}

class MemoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          body: Builder(
            builder: (context) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('メモ一覧',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                    ),),
                    Expanded(
                      child: ListView.builder(
                        itemCount: context.watch<MemoListModel>().memos.length,
                        itemBuilder: (context, index) {
                          final item = context.watch<MemoListModel>().memos[index];
                          return ListTile(
                            onTap: () async {
                              final int item = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MemoEditPage(),
                                ),
                              );

                            },
                            onLongPress: (){

                            },
                            title: Text('Item $item'),
                          );
                        },
                      ),
                    )
                  ]);
            }
          ),
          floatingActionButton: Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    final newItem = context.read<MemoListModel>().memos.length + 1;
                    context.read<MemoListModel>().addItem(newItem);
                  },
                  label: Text("新規作成"),
                ),
              );
            }
          ),
        ));
  }
}
