import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/models/contact.dart';
import 'package:platform_converter_app/providers/contact_provider.dart';
import 'package:platform_converter_app/providers/theme_provider.dart';
import 'package:platform_converter_app/widgets/chat_edit.dart';
import 'package:provider/provider.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ContactProvider, ThemeProvider>(
      builder: (context, value, platform, child) {
        if (value.contactList.isEmpty) {
          return const Center(child: Text('No any chats yet...'));
        }
        return ListView.builder(
          itemCount: value.contactList.length,
          itemBuilder: (context, index) {
            Contact data = value.contactList[index];
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
                subtitle: Text(data.chat ?? ''),
                trailing: Text('${data.date} ${data.time}'),
                onTap: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoPopupSurface(
                            isSurfacePainted: true,
                            child: ChatEdit(contact: data),
                          ));
                },
              );
            } else {
              return ListTile(
                leading: profile,
                title: Text(data.fullName ?? ''),
                subtitle: Text(data.chat ?? '098'),
                trailing: Text('${data.date},${data.time}'),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ChatEdit(contact: data);
                    },
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
