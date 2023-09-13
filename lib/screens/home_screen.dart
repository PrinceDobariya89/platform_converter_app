import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/providers/page_provider.dart';
import 'package:platform_converter_app/providers/theme_provider.dart';
import 'package:platform_converter_app/widgets/platform_switch.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context).platform;
    if (provider) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Platform Converter'),
          trailing: PlatformSwitch(),
        ),
        child: Consumer<PageProvider>(
          builder: (context, value, child) {
            return CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                onTap: (index) => value.selectedPage(index),
                currentIndex: value.selectedIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.person_add)),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.chat_bubble_2),
                      label: 'CHATS'),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.phone), label: 'CALLS'),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.settings),
                      label: 'SETTINGS'),
                ]
              ),
              tabBuilder: (context, index) {
                return value.pages[index];
                // return _pages[_selectedIndex];
              },
            );
          }
        ),
      );
    } else {
      return Consumer<PageProvider>(
        builder: (context, value, child) {
          return DefaultTabController(
            length: value.pages.length,
            initialIndex: value.selectedIndex,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Platform Converter'),
                actions: const [PlatformSwitch()],
                bottom: TabBar(
                    isScrollable: true,
                    onTap: (index) => value.selectedPage(index),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(icon: Icon(Icons.person_add_alt)),
                      Tab(text: 'CHATS'),
                      Tab(text: 'CALLS'),
                      Tab(text: 'SETTINGS')
                    ]),
              ),
              body: TabBarView(children: value.pages),
            ),
          );
        }
      );
    }
  }
}
