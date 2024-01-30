import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../apis/apis.dart';
import '../../../utils/constant.dart';

class LibraryApis extends GetxController{

  RxBool isLoading = false.obs;

  ///Add  Book
  Future addBook(String authorName, String subjectName, String bookName, String bookNo, String bookQty) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'authorName': authorName,
        'subjectName': subjectName,
        'bookName': bookName,
        'bookNo': bookNo,
        'bookQty': bookQty,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}addBooks'),
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
    }else{
      return "Authentication required";
    }
  }

  ///Apply for Issue
  Future applyIssue(String bookId) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'bookId': bookId,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}issueBook'),
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
    }else{
      return "Authentication required";
    }
  }

  ///Decrease book qty count after apply
  Future decreaseQtyCount(String bookId) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'bookId': bookId,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.put(
          Uri.parse('${Constant.baseUrl}decrementBookQty'),
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
    }else{
      return "Authentication required";
    }
  }

  ///Update To Issued
  Future updateToIssued(String issueId) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'issueId': issueId,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.put(
          Uri.parse('${Constant.baseUrl}updateToIssued'),
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
    }else{
      return "Authentication required";
    }
  }

  ///Update To Returned
  Future updateToReturned(String issueId) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'issueId': issueId,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.put(
          Uri.parse('${Constant.baseUrl}updateToReturned'),
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
    }else{
      return "Authentication required";
    }
  }

  ///Increase book qty count after returned
  Future increaseQtyCount(String bookId) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'bookId': bookId,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.put(
          Uri.parse('${Constant.baseUrl}incrementBookQty'),
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
        print("Erroe anurah: ${e.toString()}");
        throw "Error: ${e.toString()}";
      }
    }else{
      return "Authentication required";
    }
  }

}