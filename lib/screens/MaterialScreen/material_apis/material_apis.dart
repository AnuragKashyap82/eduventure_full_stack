import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'  as http;
import '../../../apis/apis.dart';
import '../../../utils/constant.dart';

class MaterialApis{

  RxBool isLoading = false.obs;

  Future<String> getPdfAndUpload(String timestamp) async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf']);

    if (result == null) {
      return "No files Selected";
    }
    isLoading.value = true;
    final path = result.files.single.path!;

    File file = File(path);
    try {
      final Reference storageReference =
      FirebaseStorage.instance.ref().child("Material").child(timestamp);
      UploadTask uploadTask = storageReference.putFile(file);
      String url = await (await uploadTask).ref.getDownloadURL();
      isLoading.value = false;
      return url;
    }  catch (e) {
      isLoading.value = false;
      return "${e.toString()}";
    }
  }

  Future uploadMaterial(String branch, String semester, String materialUrl, String subTopic, String subName) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'branch': branch,
        'semester': semester,
        'materialUrl': materialUrl,
        'subTopic': subTopic,
        'subName': subName,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}addMaterial'),
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

  Future<String> deleteMaterial(String materialId) async{
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'materialId': materialId,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}deleteMaterial'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-auth-token': token
          },
          body: requestBodyJson,
        );
        final responseBody = jsonDecode(response.body);
        if (response.statusCode == 200) {
          isLoading.value = false;
          return "${responseBody['status']}";
        } else {
          isLoading.value = false;
          return "${responseBody['status']}";
        }
      } catch (e) {
        isLoading.value = false;
        throw "Error: ${e.toString()}";
      }
    }else{
      return "Authentication required";
    }

  }

}