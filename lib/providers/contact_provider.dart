import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter_app/models/contact.dart';

class ContactProvider extends ChangeNotifier {
  final List<Contact> _contactList = [];
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _chatController = TextEditingController();
  String _image = '';
  String _currentTime = 'Pick Time';
  String _currentDate = 'Pick Date';

  List<Contact> get contactList => _contactList;

  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get chatController => _chatController;

  String get image => _image;
  String get currentTime => _currentTime;
  String get currentDate => _currentDate;

  void addContact() {
    Contact contact = Contact(
        image: _image,
        fullName: _fullNameController.text,
        phone: _phoneController.text,
        chat: _chatController.text,
        date: _currentDate=='Pick Date'?'':_currentDate,
        time: _currentTime=='Pick Time'?'':_currentTime);
    _contactList.add(contact);
    clear();
    notifyListeners();
  }

  void deleteChat(Contact contact) {
    _contactList.removeWhere((element) => element == contact);
    notifyListeners();
  }

  // clear textfield
  void clear() {
    _image = '';
    _fullNameController.text = '';
    _phoneController.text = '';
    _chatController.text = '';
    _currentTime = 'Pick Time';
    _currentDate = 'Pick Date';
  }

  void pickDate(DateTime value){
    _currentDate = '${value.day}/${value.month}/${value.year}';
    notifyListeners();
  }

  void pickTime(var value){
    _currentTime = '${value.hour}:${value.minute}';
    notifyListeners();
  }

  void setimage(String img) {
    _image = img;
    notifyListeners();
  }

  Future<String> pickImage() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    return pickedImage?.path ?? '';
  }
}
