import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/providers/contact_provider.dart';
import 'package:platform_converter_app/providers/theme_provider.dart';
import 'package:platform_converter_app/utils/utils.dart';
import 'package:provider/provider.dart';

class CallList extends StatelessWidget {
  const CallList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ContactProvider, ThemeProvider>(
      builder: (context, value, platform, child) {
        if (value.contactList.isEmpty) {
          return const Center(child: Text('No any calls yet...'));
        }
        return ListView.builder(
          itemCount: value.contactList.length,
          itemBuilder: (context, index) {
            var data = value.contactList[index];
            final profile = data.image != ''
                ? CircleAvatar(
                    backgroundImage: FileImage(File(data.image)),
                  )
                : const CircleAvatar(
                  );
            if (platform.platform) {
              return CupertinoListTile(
                leading: profile,
                title: Text(data.fullName ?? ''),
                subtitle: Text(data.phone ?? ''),
                trailing: GestureDetector(
                    onTap: () {
                      Utils().call(data.phone);
                    },
                    child: const Icon(
                      CupertinoIcons.phone_fill,
                      color: Colors.green,
                    )),
              );
            } else {
              return ListTile(
                leading: profile,
                title: Text(data.fullName ?? ''),
                subtitle: Text(data.phone ?? ''),
                trailing: IconButton(
                    onPressed: () {
                      Utils().call(data.phone);
                    },
                    icon: const Icon(
                      Icons.call,
                      color: Colors.green,
                    )),
              );
            }
          },
        );
      },
    );
  }
}
