import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/providers/theme_provider.dart';
import 'package:platform_converter_app/widgets/platform_switch.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget implements PreferredSize {
  const TopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context).platform;
    print(provider);
    return provider
        ? const CupertinoNavigationBar(
            middle: Text('Platform Converter'),
            trailing: PlatformSwitch(),
          )
        : AppBar(
            title: const Text('Platform Converter'),
            actions: const [PlatformSwitch()],
          );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
