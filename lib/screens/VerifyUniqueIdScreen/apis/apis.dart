import 'dart:convert';

import 'package:eduventure_nodejs/utils/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VerifyUniqueIdApis extends GetxController {
  RxString email = ''.obs;
  RxString studentId = ''.obs;
  RxString userType = ''.obs;
  RxBool isLoading = false.obs;

  Future<String> VerifyUniqueId(String uniqueId) async {
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}verifyStudentId/$uniqueId'),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;

        // Decode the response body


        // Check if the status is true
        if (responseBody['status']) {
          // Access the student details
          Map<String, dynamic> studentDetails = responseBody['existingStudentId'];

          // Update the variables with the student details
          email.value = studentDetails['email'];
          studentId.value = studentDetails['studentId'].toString();
          userType.value = studentDetails['userType'];

          return "verified";
        } else {
          // Handle the case where status is false or other error conditions
          isLoading.value = false;
          email.value = '';
          studentId.value = '';
          userType.value = '';
          return "Failed to verify student ID";

        }
      } else {
        isLoading.value = false;
        isLoading.value = false;
        email.value = '';
        studentId.value = '';
        userType.value = '';
        return "${responseBody['msg']}";
      }
    } catch (e) {
      isLoading.value = false;
      isLoading.value = false;
      email.value = '';
      studentId.value = '';
      userType.value = '';
      return "An error occurred: $e";
    }
  }
}
