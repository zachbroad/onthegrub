import 'package:url_launcher/url_launcher.dart';

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

launchCall(String phone) async {
  String tel = 'tel: ${phone.replaceAll('(', '').replaceAll(')', '').replaceAll('-', '').replaceAll(' ', '')}';
  if (await canLaunch(tel)) {
    await launch(tel);
  } else {
    throw 'Could not launch $phone';
  }
}
