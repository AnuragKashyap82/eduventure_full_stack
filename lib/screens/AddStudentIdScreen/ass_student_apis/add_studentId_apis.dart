import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../apis/apis.dart';
import '../../../utils/constant.dart';

class AddStudentIdApis extends GetxController{

  RxBool isLoading = false.obs;

  Future addStudentId(String studentId, String email, String userType) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'studentId': studentId,
        'email': email,
        'userType': userType,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}addStudentId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-auth-token': token
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
    }else{
      return "Authentication required";
    }
  }

}