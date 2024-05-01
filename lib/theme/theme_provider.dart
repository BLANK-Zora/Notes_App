import 'package:flutter/material.dart';
import 'package:flutter_application_3/theme/theme.dart';

class ThemeProvider with ChangeNotifier {

  //initially the theme is light mode
  ThemeData _themedata = lightmode;

  //getter method to access the theme from other part of the code
  ThemeData get themeData => _themedata;

  //getter method to see if we are in dark mode or not
  bool get isDarkMode => _themedata == darkmode;


  //setter method to set new theme
  set themeData(ThemeData themeData) {
    _themedata = themeData;
    notifyListeners();
  }

  //toggeling between the themes
  void toggleTheme() {
    if (_themedata == lightmode) {
      themeData = darkmode;
    } else {
      themeData = lightmode;
    }
  }
}
