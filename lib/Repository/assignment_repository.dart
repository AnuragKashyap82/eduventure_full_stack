import 'dart:convert';
import 'package:eduventure_nodejs/Model/class_ass_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../apis/apis.dart';
import '../utils/constant.dart';

class AssignmentRepository extends GetxController {
  static AssignmentRepository get instance => Get.find();

  Future<List<AssignmentModel>> getAllAssignment(String classCode) async {
    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        "classCode": classCode,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}getAllAssignment'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-auth-token': token
          },
          body: requestBodyJson,
        );

        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          List<dynamic> assData = responseBody['assignment'];
          List<AssignmentModel> assignment = assData
              .map((assJson) => AssignmentModel.fromJson(assJson))
              .toList();
          return assignment;
        } else {
          throw "Failed to fetch assignment: ${responseBody['error']}";
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
