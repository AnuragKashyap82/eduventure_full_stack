import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Model/issue_book_model.dart';
import '../utils/constant.dart';

class IssueBookRepository extends GetxController {
  static IssueBookRepository get instance => Get.find();

  Future<List<IssueBookModel>> getAllIssuedBooks(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}getAllIssuedBooks'),
        headers: {
          'x-auth-token': token,
        },
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> issuedData = json.decode(response.body)['issueBooks'];
        final List<IssueBookModel> issuedBooks = issuedData
            .map((noticeJson) => IssueBookModel.fromJson(noticeJson))
            .toList();
        return issuedBooks;
      } else {
        throw "Failed to load issuedBooks: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

}
