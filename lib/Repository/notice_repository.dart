import 'dart:convert';
import 'package:eduventure_nodejs/utils/constant.dart';
import 'package:http/http.dart' as http;
import '../Model/notice_model.dart';

class NoticeRepository {
  static NoticeRepository get instance => NoticeRepository();

  Future<List<NoticeModel>> getAllNotices(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}getAllNotice'),
        headers: {
          'x-auth-token': token,
        },
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> noticeData = json.decode(response.body)['notice'];
        final List<NoticeModel> notices = noticeData
            .map((noticeJson) => NoticeModel.fromJson(noticeJson))
            .toList();
        return notices;
      } else {
        throw "Failed to load notices: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
