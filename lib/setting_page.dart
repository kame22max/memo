import 'package:flutter/material.dart';
import 'package:memo/memo_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// テーマ情報を管理するNotifier
class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();

  ThemeData get currentTheme => _currentTheme;

  void setThemeColor(Color color) {
    _currentTheme = ThemeData.light().copyWith(primaryColor: color);
    notifyListeners();
  }
}

class DarkThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    _saveDarkModeSetting(_isDarkMode); // ダークモードの設定を保存

    notifyListeners();
  }
  Future<void> _saveDarkModeSetting(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
  }

  Future<void> loadDarkModeSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('darkMode') ?? false;
    notifyListeners();
  }

  ThemeData getTheme() {
    return _isDarkMode ? ThemeData.dark() : ThemeData.light();
  }
}

class SettingPage extends StatelessWidget {
  final List<Color> themeColors = [Colors.red, Colors.blue, Colors.yellow];

  @override
  Widget build(BuildContext context) {
    final memoListProvider = Provider.of<MemoListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            for (var color in themeColors)
              ListTile(
                title: Text(color.toString()),
                onTap: () {
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .setThemeColor(color);
                  Navigator.pop(context); // 設定画面を閉じる
                },
              ),
    ListTile(
    title: Text('Dark Mode'),
    trailing: Switch(
    value: Provider.of<DarkThemeNotifier>(context).isDarkMode,
    onChanged: (value) {
    Provider.of<DarkThemeNotifier>(context, listen: false)
        .toggleDarkMode();
    },
    ),
    ),

            Divider(),
            Text(
              'メモを全削除',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () async {
                await memoListProvider.deleteAllMemosWithConfirmation(context);
              },
            ),
          ],
        ),
      ),

    );
  }
}
