import 'package:flutter/material.dart';
import 'package:memo/memo_list_page.dart';
import 'package:memo/memo_list_provider.dart';
import 'package:memo/setting_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => DarkThemeNotifier()..loadDarkModeSetting()),
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
        ChangeNotifierProvider(create: (context) => MemoListProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<DarkThemeNotifier>(context).getTheme(),
      home: MemoListPage(),
    );
  }
}
