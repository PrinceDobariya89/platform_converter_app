import 'package:flutter/widgets.dart';

import '../screens/addedit_screen.dart';
import '../screens/call_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/setting_screen.dart';

class PageProvider extends ChangeNotifier {
  final List<Widget> _pages = [
    const AddEditScreen(),
    const ChatScreen(),
    const CallScreen(),
    const SettingScreen()
  ];
  int selectedIndex = 1;
  List<Widget> get pages => _pages;

  void selectedPage(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
