import 'package:flutter/material.dart';
import 'package:memo/add_memo_page.dart';
import 'package:memo/memo_list_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MemoListProvider(),
      child: MaterialApp(
        home: MemoListPage(),
      ),
    );
  }
}
