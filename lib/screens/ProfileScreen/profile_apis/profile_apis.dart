import 'dart:convert';
import 'package:eduventure_nodejs/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:eduventure_nodejs/apis/apis.dart';
import 'package:get/get.dart';

import '../../../Controller/time_table_controller.dart';
import '../../../Controller/time_table_faculty_controller.dart';
import '../../../Controller/user_controller.dart';

class ProfileApis extends GetxController{

  RxBool isLoading = false.obs;

  Future<void> clearControllers() async {
    Get.delete<UserController>();
    // Get.delete<ClassroomController>();
    Get.delete<FacultyTimeTableControllerController>();
    Get.delete<TimeTableController>();
  }

  Future<String> updateProfile(
    String name,
    String completeAddress,
    String dob,
    String regNo,
    String branch,
    String semester,
    String seatType,
    String session,
    String photoUrl,
  ) async {
    isLoading.value = true;
    try {
      String? authToken = await Apis().getToken();
      final apiUrl =
          Uri.parse('${Constant.baseUrl}updateProfile');

      final headers = {
        'Content-Type': 'application/json',
        'x-auth-token': '$authToken',
      };

      final data = {
        'name': name,
        'completeAddress': completeAddress,
        'dob': dob,
        'regNo': regNo,
        'branch': branch,
        'semester': semester,
        'session': session,
        'seatType': seatType,
        'photoUrl': photoUrl,
      };
      final response = await http.put(
        apiUrl,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        return "${response.body}"; // Data posted successfully
      } else {
        isLoading.value = false;
        print('HTTP Error: ${response.statusCode} ${response.body}');
        return "HTTP Error:${response.statusCode} ${response.body}"; // Data posting failed
      }
    } catch (error) {
      isLoading.value = false;
      print('Error: $error');
      return "Error Occurred-$error"; // Data posting failed
    }
  }
}
