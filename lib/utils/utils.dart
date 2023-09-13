import 'package:url_launcher/url_launcher.dart';


class Utils{
  call(String? phone){
    launchUrl(Uri.parse('tel:$phone'));
  }
}