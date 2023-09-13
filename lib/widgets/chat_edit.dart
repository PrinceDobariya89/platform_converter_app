import 'dart:io';

import 'package:flutter/material.dart';
import 'package:platform_converter_app/models/contact.dart';
import 'package:platform_converter_app/providers/contact_provider.dart';
import 'package:provider/provider.dart';

class ChatEdit extends StatelessWidget {
  final Contact contact;
  const ChatEdit({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          contact.image != ''
              ? CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(File(contact.image)),
                )
              : const CircleAvatar(
                  radius: 50,
                ),
          const SizedBox(height: 5),
          Text(
            contact.fullName ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(contact.chat ?? '', maxLines: 2),
          const SizedBox(height: 10),
          Consumer<ContactProvider>(builder: (context, value, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.edit),
                const SizedBox(width: 20),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Provider.of<ContactProvider>(context, listen: false)
                          .deleteChat(contact);
                    },
                    child: const Icon(Icons.delete))
              ],
            );
          }),
          OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'))
        ],
      ),
    );
  }
}
