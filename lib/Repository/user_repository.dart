import 'dart:convert';
import 'package:eduventure_nodejs/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:eduventure_nodejs/Model/user_model.dart';
import 'package:eduventure_nodejs/apis/apis.dart';
import 'package:eduventure_nodejs/utils/global_variables.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  RxBool isLoading = false.obs;

  Future<UserModel> fetchUserData(String token) async {
    isLoading.value = false;

    final headers = <String, String>{};
    headers['x-auth-token'] = token;

    final response = await http.get(
      Uri.parse('${Constant.baseUrl}getMyProfile'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      final userData = json.decode(response.body)['user'];
      return UserModel.fromJson(userData);
    } else {
      throw Exception('Failed to load data');
    }
  }

}
