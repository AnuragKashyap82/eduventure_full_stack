import 'dart:convert';

import 'package:eduventure_nodejs/Model/books_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Model/issue_book_model.dart';
import '../utils/constant.dart';

class BooksRepository extends GetxController {
  static BooksRepository get instance => Get.find();

  Future<List<BooksModel>> getAllBooks(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}getAllBooks'),
        headers: {
          'x-auth-token': token,
        },
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> bookData = json.decode(response.body)['books'];
        final List<BooksModel> books = bookData
            .map((bookJson) => BooksModel.fromJson(bookJson))
            .toList();
        print('Response Boosk status code: ${books}');
        return books;
      } else {
        throw "Failed to load books: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

  Future<List<IssueBookModel>> getMyIssueBooks(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}getMyIssuedBooks'),
        headers: {
          'x-auth-token': token,
        },
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> bookData = json.decode(response.body)['issueBooks'];
        final List<IssueBookModel> books = bookData
            .map((bookJson) => IssueBookModel.fromJson(bookJson))
            .toList();
        print('Response Boosk status code: ${books}');
        return books;
      } else {
        throw "Failed to load My issueBooks: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
