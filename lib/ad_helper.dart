import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1234567890123456/3333333333';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1234567890123456/7777777777';
    } else {
      // ignore: unnecessary_new
      throw new UnsupportedError('Unsupported platform');
    }
  }
}