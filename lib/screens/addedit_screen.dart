import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/providers/contact_provider.dart';
import 'package:platform_converter_app/providers/theme_provider.dart';
import 'package:platform_converter_app/widgets/profile_pic.dart';
import 'package:provider/provider.dart';

class AddEditScreen extends StatelessWidget {
  const AddEditScreen({super.key});

  static BoxDecoration iosDecoration = BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(5));

  InputDecoration androidDecoration(String label, IconData icon) =>
      InputDecoration(
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
          border: const OutlineInputBorder(),
          labelText: label,
          prefixIcon: Icon(icon));

  @override
  Widget build(BuildContext context) {
    final isIos = Provider.of<ThemeProvider>(context).platform;
    final value = Provider.of<ContactProvider>(context);
    if (isIos) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ProfilePic(),
              ),
              CupertinoTextFormFieldRow(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: value.fullNameController,
                placeholder: 'Full Name',
                prefix: const Icon(CupertinoIcons.person),
                decoration: iosDecoration,
              ),
              CupertinoTextFormFieldRow(
                controller: value.phoneController,
                placeholder: 'Phone Number',
                prefix: const Icon(CupertinoIcons.phone),
                decoration: iosDecoration,
              ),
              CupertinoTextFormFieldRow(
                controller: value.chatController,
                placeholder: 'Chat Conversation',
                prefix: const Icon(CupertinoIcons.chat_bubble_text),
                decoration: iosDecoration,
              ),
              CupertinoTextFormFieldRow(
                controller: TextEditingController(text: value.currentDate),
                readOnly: true,
                prefix: const Icon(CupertinoIcons.calendar),
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => SizedBox(
                      height: 190,
                      child: CupertinoDatePicker(
                        showDayOfWeek: true,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (v) => value.pickDate(v)
                      ),
                    ),
                  );
                },
              ),
              CupertinoTextFormFieldRow(
                controller: TextEditingController(text: value.currentTime),
                readOnly: true,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => SizedBox(
                      height: 190,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (v) {
                          value.pickTime(v);
                        },
                      ),
                    ),
                  );
                },
                prefix: const Icon(CupertinoIcons.time),
              ),
              CupertinoButton(
                  color: Colors.blue,
                  onPressed: () {
                    Provider.of<ContactProvider>(context,
                            listen: false)
                        .addContact();
                  },
                  child: const Text('SAVE'))
            ],
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ProfilePic(),
              ),
              TextField(
                  controller: value.fullNameController,
                  decoration: androidDecoration(
                      'Full Name', Icons.person_2_outlined)),
              const SizedBox(height: 10),
              TextField(
                  controller: value.phoneController,
                  keyboardType: TextInputType.number,
                  decoration:
                      androidDecoration('Phone Number', Icons.call)),
              const SizedBox(height: 10),
              TextField(
                  controller: value.chatController,
                  decoration: androidDecoration(
                      'Chat Conversation', Icons.chat_outlined)),
              const SizedBox(height: 10),
              Row(
                children: [
                  TextButton.icon(
                      style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1990),
                                lastDate: DateTime(2050))
                            .then((v) {
                          if (v != null) {
                            value.pickDate(v);
                          }
                        });
                      },
                      icon: const Icon(Icons.date_range),
                      label: Text(value.currentDate)),
                  TextButton.icon(
                      style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory),
                      onPressed: () {
                        showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now())
                            .then((v) {
                          if (v != null) {
                            value.pickTime(v);
                          }
                        });
                      },
                      icon: const Icon(Icons.access_time_outlined),
                      label: Text(value.currentTime)),
                ],
              ),
              OutlinedButton(
                  onPressed: () {
                    Provider.of<ContactProvider>(context,
                            listen: false)
                        .addContact();
                  },
                  child: const Text('SAVE'))
            ],
          ),
        ),
      );
    }
  }
}
