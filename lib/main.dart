import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/providers/contact_provider.dart';
import 'package:platform_converter_app/providers/page_provider.dart';
import 'package:platform_converter_app/providers/theme_provider.dart';
import 'package:platform_converter_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
late SharedPreferences pref;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
      ],
      builder: (context, child) {
        final provider = Provider.of<ThemeProvider>(context);
        return Provider.of<ThemeProvider>(context).platform
            ? CupertinoApp(
                debugShowCheckedModeBanner: false,
                theme: CupertinoThemeData(
                  brightness: provider.isDark
                      ? Brightness.dark
                      : Brightness.light,
                ),
                home: const HomeScreen(),
              )
            : MaterialApp(
                title: 'Platform Converter',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  brightness: provider.isDark
                      ? Brightness.dark
                      : Brightness.light,
                  useMaterial3: true,
                ),
                home: const HomeScreen(),
              );
      },
    );
  }
}
