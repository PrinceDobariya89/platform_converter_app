import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/providers/theme_provider.dart';
import 'package:platform_converter_app/widgets/call_list.dart';
import 'package:provider/provider.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context).platform;
    if (provider) {
      return const CupertinoPageScaffold(child: CallList());
    } else {
      return const Scaffold(body: CallList());
    }
  }
}
