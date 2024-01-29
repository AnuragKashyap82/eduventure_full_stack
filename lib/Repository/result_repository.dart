import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Model/result_model.dart';
import '../utils/constant.dart';

class ResultRepository extends GetxController {
  static ResultRepository get instance => Get.find();

  Future<List<ResultModel>> getAllResult(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}getAllResult'),
        headers: {
          'x-auth-token': token,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> resultData = json.decode(response.body)['result'];
        final List<ResultModel> result = resultData
            .map((resultJson) => ResultModel.fromJson(resultJson))
            .toList();

        return result;
      } else {
        throw "Failed to load result: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
