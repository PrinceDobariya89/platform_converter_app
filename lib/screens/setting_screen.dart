import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/providers/theme_provider.dart';
import 'package:platform_converter_app/widgets/profile.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, v, child) {
        if (v.platform) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 10),
                child: Column(children: [
                  CupertinoListTile(
                    leading: const Icon(CupertinoIcons.person),
                    title: const Text('Profile'),
                    subtitle: const Text('Update Profile Data'),
                    trailing: CupertinoSwitch(
                        value: v.profile,
                        onChanged: (_) => v.changeProfile()),
                  ),
                  Profile(visible: v.profile, platform: v.platform),
                  const Divider(),
                  CupertinoListTile(
                    leading: const Icon(CupertinoIcons.sun_max),
                    title: const Text('Theme'),
                    subtitle: const Text('Change Theme'),
                    trailing: CupertinoSwitch(
                        value: v.isDark,
                        onChanged: (_) => v.changeTheme()),
                  ),
                ]),
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                      secondary: const Icon(Icons.person),
                      title: const Text('Profile'),
                      subtitle: const Text('Update Profile Data'),
                      value: v.profile,
                      onChanged: (_) => v.changeProfile()),
                  Profile(visible: v.profile, platform: v.platform),
                  const Divider(),
                  SwitchListTile.adaptive(
                      secondary:
                          const Icon(Icons.light_mode_outlined),
                      title: const Text('Theme'),
                      subtitle: const Text('Change Theme'),
                      value: v.isDark,
                      onChanged: (_) => v.changeTheme()),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
