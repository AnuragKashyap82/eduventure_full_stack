import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Apis{

  ///Launch Email
  Future<void> launchEmail()async {
    String? encodeQueryParameters(Map<String, String> params,) {
      return params.entries
          .map(
            (MapEntry<String, String> e) =>
        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
      )
          .join('&');
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'lmsramgarhengineering@gmail.com',
      query: encodeQueryParameters(
        <String, String>{
          'subject': 'Need help',
        },
      ),
    );

    if (await canLaunchUrl(emailUri)) {
      launchUrl(emailUri);
    } else {
      throw Exception(
        "Could not launch $emailUri",
      );
    }
  }

  Future<String> getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token') ?? '';
    return token;
  }

  Future<void> removeToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

}