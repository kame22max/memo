import 'package:flutter/material.dart';
import 'package:memo/memo_list_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MemoListModel(),
        child: MaterialApp(
          home: MemoListPage(),
        ),
    );
  }
}


