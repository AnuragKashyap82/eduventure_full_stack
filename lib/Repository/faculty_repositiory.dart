import 'dart:convert';

import 'package:eduventure_nodejs/Model/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class FacultyRepository extends GetxController {
  static FacultyRepository get instance => Get.find();



  Future<List<UserModel>> getAllFaculty(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}getAllFaculty'),
        headers: {
          'x-auth-token': token,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> facultyData = json.decode(response.body)['faculty'];

        // Filter timetable data based on semester and branch
        final List<UserModel> filteredFaculty = facultyData
            .map((timeTableJson) => UserModel.fromJson(timeTableJson))
            .toList();

        return filteredFaculty;
      } else {
        throw "Failed to load faculty: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
