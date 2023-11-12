import 'package:flutter/material.dart';
import 'package:memo/memo_domain.dart';
import 'package:memo/memo_list_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {

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
            TextFormField(

            ),
            SizedBox(height: 16),
            TextFormField(


            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {

                Navigator.pop(context);
              },
              child: Text('保存'),
            ),
            SizedBox(height: 2),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text('キャンセル'),
            ),
          ],
        ),
      ),
    );
  }
}
