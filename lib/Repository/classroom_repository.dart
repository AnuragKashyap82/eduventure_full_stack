import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Model/classroom_model.dart';
import '../utils/constant.dart';

class ClassroomRepository extends GetxController {
  static ClassroomRepository get instance => Get.find();

  Future<List<ClassroomModel>> getMyClassroom(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}getMyClassroom'),
        headers: {
          'x-auth-token': token,
        },
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> bookData = json.decode(response.body)['classrooms'];
        final List<ClassroomModel> books = bookData
            .map((bookJson) => ClassroomModel.fromJson(bookJson))
            .toList();
        return books;
      } else {
        throw "Failed to load My issueBooks: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
