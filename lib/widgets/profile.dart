import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/main.dart';

class Profile extends StatelessWidget {
  final bool visible;
  final bool platform;

  Profile(
      {super.key, required this.visible, required this.platform});

  final nameController = TextEditingController(text: pref.getString('name')??'');

  final bioController = TextEditingController(text: pref.getString('bio')??'');

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: visible,
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(CupertinoIcons.camera),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: platform
                  ? Column(
                      children: [
                        CupertinoTextField(
                          controller: nameController,
                          decoration: const BoxDecoration(),
                          textAlign: TextAlign.center,
                          placeholder: 'Enter your name...',
                        ),
                        CupertinoTextField(
                          controller: bioController,
                          decoration: const BoxDecoration(),
                          textAlign: TextAlign.center,
                          placeholder: 'Enter your bio...',
                        )
                      ],
                    )
                  : Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Enter your name...'),
                          textAlign: TextAlign.center,
                        ),
                        TextField(
                          controller: bioController,
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Enter your bio...'),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: () {
                      if(nameController.text.isNotEmpty && bioController.text.isNotEmpty) {
                        pref.setString('name', nameController.text);
                        pref.setString(('bio'), bioController.text);
                      }
                    }, child: const Text('SAVE')),
                TextButton(
                    onPressed: () {
                      nameController.text = '';
                      bioController.text = '';
                      pref.remove('name');
                      pref.remove('bio');
                    }, child: const Text('CLEAR'))
              ],
            )
          ],
        ));
  }
}
