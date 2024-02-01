import 'dart:convert';
import 'package:eduventure_nodejs/Model/class_post_msg_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../apis/apis.dart';
import '../utils/constant.dart';

class ClassPostMsgRepository extends GetxController {
  static ClassPostMsgRepository get instance => Get.find();

  Future<List<PostMsgModel>> getAllClassMessage(String classCode) async {
    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        "classCode": classCode,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}getClassroomAllMessage'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-auth-token': token
          },
          body: requestBodyJson,
        );

        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          List<dynamic> messagesData = responseBody['classMsg'];
          List<PostMsgModel> messages = messagesData
              .map((messageJson) => PostMsgModel.fromJson(messageJson))
              .toList();
          return messages;
        } else {
          throw "Failed to fetch messages: ${responseBody['error']}";
        }
      } catch (e) {
        throw "Error: ${e.toString()}";
      }
    } else {
      return []; // Return an empty list if the token is empty.
    }
  }


}
