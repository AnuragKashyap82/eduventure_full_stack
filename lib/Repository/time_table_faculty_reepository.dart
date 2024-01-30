import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Model/time_table_model.dart';
import '../utils/constant.dart';

class TimetableFacultyRepository extends GetxController {
  static TimetableFacultyRepository get instance => Get.find();

  Future<List<TimetableModel>> getAllFacultyTimeTable(String token, String facultyId) async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}getAllTimeTable'),
        headers: {
          'x-auth-token': token,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> timeTableData = json.decode(response.body)['timeTable'];

        // Filter timetable data based on semester and branch
        final List<TimetableModel> filteredTimeTable = timeTableData
            .where((timeTableJson) => timeTableJson['facultyId'] == facultyId)
            .map((timeTableJson) => TimetableModel.fromJson(timeTableJson))
            .toList();

        return filteredTimeTable;
      } else {
        throw "Failed to load timeTable: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
