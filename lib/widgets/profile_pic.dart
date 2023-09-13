import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/providers/contact_provider.dart';
import 'package:provider/provider.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(builder: (context, value, child) {
      return GestureDetector(
        onTap: () async{
          String pickedImage = await value.pickImage();
          value.setimage(pickedImage);
        },
        child: value.image != ''
        ? CircleAvatar(radius: 50, backgroundImage: FileImage(File(value.image)))
        : const CircleAvatar(radius: 50, child: Icon(CupertinoIcons.camera)),);
    },);
  }
}
