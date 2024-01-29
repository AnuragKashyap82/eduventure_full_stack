import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';

class RegisterApi extends GetxController {
  RxBool isLoading = false.obs;

  Future<Map<String, dynamic>> register(String email, String password, String name, String userType, String studentId) async {
    isLoading.value = true;

    final requestBody = {
      'name': name,
      'email': email,
      'password': password,
      'userType': userType,
      'studentId': studentId
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}signup'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: requestBodyJson,
      );
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        return responseBody;
      } else {
        isLoading.value = false;
        return responseBody;
      }
    } catch (e) {
      isLoading.value = false;
      throw "Error: ${e.toString()}";
    }
  }
}
