import 'package:flutter/material.dart';
import 'package:memo/memo_list_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '20文字メモ',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MemoListPage(),
    );
  }
}


