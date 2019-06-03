import 'package:flutter/material.dart';
import 'BLoCBase.dart';
import 'package:rxdart/rxdart.dart';

class ThemeDataBLoC extends BLoCBase {

  ThemeData _themeData = ThemeData(
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Color(0xFFF3F4FA)
  );

  var _subject = BehaviorSubject<ThemeData>();

  Stream<ThemeData> get stream => _subject.stream;
  ThemeData get value => _themeData;

  changeTheme(int colorIndex) {
    MaterialColor color;
    switch(colorIndex) {
      case 0:
        color = Colors.green;
        break;
      case 1:
        color = Colors.red;
        break;
      case 2:
        color = Colors.pink;
        break;
      case 3:
        color = Colors.teal;
        break;
      case 4:
        color = Colors.blue;
        break;
      case 5:
        color = Colors.purple;
        break;
      default:
        color = Colors.green;
        break;
    }
    _themeData = ThemeData(
        primarySwatch: color,
        scaffoldBackgroundColor: Color(0xFFF3F4FA)
    );
    _subject.sink.add(_themeData);
  }

  @override
  void dispose() {
    _subject.close();
  }

}