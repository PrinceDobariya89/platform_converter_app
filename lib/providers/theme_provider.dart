import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  bool platform = false;
  bool isDark = false;
  bool profile = false;

  void changeTheme(){
    isDark = !isDark;
    notifyListeners();
  }

  void changePlatform(){
    platform = !platform;
    notifyListeners();
  }

  void changeProfile(){
    profile = !profile;
    notifyListeners();
  }
}