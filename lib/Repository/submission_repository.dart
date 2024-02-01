import 'dart:convert';
import 'dart:math';
import 'package:eduventure_nodejs/Model/submission_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../apis/apis.dart';
import '../utils/constant.dart';

class SubmissionRepository extends GetxController {
  static SubmissionRepository get instance => Get.find();

  Future<List<SubmissionModel>> getAllSubmission(String classCode, String assignmentId) async {
    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        "classCode": classCode,
        "assignmentId": assignmentId,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}getAllAssSubmittedName'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-auth-token': token
          },
          body: requestBodyJson,
        );

        final responseBody = jsonDecode(response.body);

        print("classCode $classCode");
        print("assId $assignmentId");
        print("All: $responseBody");

        if (response.statusCode == 200) {
          List<dynamic> submissionData = responseBody['submission'];
          List<SubmissionModel> submission = submissionData
              .map((assJson) => SubmissionModel.fromJson(assJson))
              .toList();
          return submission;

        } else {
          throw "Failed to fetch assignment: ${responseBody}";
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
