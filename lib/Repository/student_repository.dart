import 'dart:convert';
import 'package:eduventure_nodejs/Model/student_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../apis/apis.dart';
import '../utils/constant.dart';

class StudentRepository extends GetxController {
  static StudentRepository get instance => Get.find();

  Future<List<StudentModel>> getAllStudent(String classCode) async {
    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        "classCode": classCode,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}getAllStudents'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-auth-token': token
          },
          body: requestBodyJson,
        );

        final responseBody = jsonDecode(response.body);

        print("Student : ${response.body}");

        if (response.statusCode == 200) {
          List<dynamic> studentData = responseBody['students'];
          List<StudentModel> student = studentData
              .map((studentJson) => StudentModel.fromJson(studentJson))
              .toList();
          return student;

        } else {
          throw "Failed to fetch student: ${responseBody}";
        }
      } catch (e) {
        if (e is Map<String, dynamic>) {
          throw "JSON Parsing Error: $e";
        } else {
          throw "Catch Error: ${e.toString()}";
        }
      }
    } else {
      return []; // Return an empty list if the token is empty.
    }
  }

}
