import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constant.dart';

class LoginApis extends GetxController {
  RxBool isLoading = false.obs;

  Future<Map<String, dynamic>> login(String email, String password) async {
    isLoading.value = true;

    final requestBody = {
      'email': email,
      'password': password,
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}signin'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: requestBodyJson,
      );

      isLoading.value = false;
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {

        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      throw "Error: ${e.toString()}";
    }
  }

  Future<void> saveToken(String token)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

}
