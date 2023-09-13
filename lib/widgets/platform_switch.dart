import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class PlatformSwitch extends StatelessWidget {
  const PlatformSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, v, child) => v.platform
          ? CupertinoSwitch(
              value: v.platform,
              onChanged: (value) => v.changePlatform())
          : Switch(
              value: v.platform,
              onChanged: (value) {
                v.changePlatform();
              }),
    );
  }
}
