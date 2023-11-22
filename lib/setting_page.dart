import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeColor { Red, Green, Blue }

class ThemeNotifier extends ChangeNotifier {

  bool _isDarkMode = false;
  AppThemeColor _appThemeColor = AppThemeColor.Red; // 初期テーマカラー

  bool get isDarkMode => _isDarkMode;
  AppThemeColor get appThemeColor => _appThemeColor;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    _saveDarkModeSetting(_isDarkMode);
    notifyListeners();
  }

  void setAppThemeColor(AppThemeColor color) {
    print('Selected Theme Color: $color');

    _saveAppThemeColor(color);
    _appThemeColor = color;
    notifyListeners();
  }

  void _saveDarkModeSetting(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
  }

  void _saveAppThemeColor(AppThemeColor color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('appThemeColor', color.index);
  }

  void loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('darkMode') ?? false;
    int themeColorIndex = prefs.getInt('appThemeColor') ?? AppThemeColor.Red.index;
    _appThemeColor = AppThemeColor.values[themeColorIndex];
    notifyListeners();
  }

  ThemeData getTheme() {
    Color primaryColor;
    switch (_appThemeColor) {
      case AppThemeColor.Red:
        primaryColor = Colors.red;
        break;
      case AppThemeColor.Green:
        primaryColor = Colors.green;
        break;
      case AppThemeColor.Blue:
        primaryColor = Colors.blue;
        break;
    }

    return _isDarkMode
        ? ThemeData.dark().copyWith(primaryColor: primaryColor)
        : ThemeData.light().copyWith(primaryColor: primaryColor);
  }
}


class SettingPage extends StatelessWidget {
  final List<Color> themeColors = [Colors.red, Colors.blue, Colors.yellow];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('ダークモード'),
              trailing: CupertinoSwitch(
                value: Provider.of<ThemeNotifier>(context).isDarkMode,
                onChanged: (value) {
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .toggleDarkMode();
                },
              ),
            ),
            ListTile(
              title: Text('Theme Color'),
              trailing: DropdownButton(
                value: Provider.of<ThemeNotifier>(context).appThemeColor,
                items: AppThemeColor.values.map((color) {
                  return DropdownMenuItem(
                    value: color,
                    child: Text(color.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .setAppThemeColor(value!);
                },
              ),
            ),
            ListTile(
              title: Text('全てのメモを削除'),
              onTap: (){

              },
            )
          ],
        ),
      ),
    );
  }
}
