import 'dart:convert';

import 'package:eduventure_nodejs/Controller/time_table_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../apis/apis.dart';
import '../../../utils/constant.dart';

class TimeTableApis extends GetxController {
  RxBool isLoading = false.obs;
  TimeTableController timeTableController = Get.find();

  Future<void> clearTimeTableController() async{
    timeTableController.subjectName.value = "";
    timeTableController.subjectCode.value = "";
    timeTableController.facultyName.value = "";
    timeTableController.startTime.value = "";
    timeTableController.endTime.value = "";
  }

  Future addTimeTable(
      String branch,
      String semester,
      String dayName,
      String subName,
      String subCode,
      String facultyName,
      String facultyId,
      String startTime,
      String endTime) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'branch': branch,
        'semester': semester,
        'dayName': dayName,
        'subName': subName,
        'subCode': subCode,
        'facultyName': facultyName,
        'facultyId': facultyId,
        'startTime': startTime,
        'endTime': endTime,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}addTimeTable'),
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
    } else {
      return "Authentication required";
    }
  }
}
