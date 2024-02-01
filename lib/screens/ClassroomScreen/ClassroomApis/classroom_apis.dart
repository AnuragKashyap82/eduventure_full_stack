import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../apis/apis.dart';
import '../../../utils/constant.dart';

class ClassroomApis extends GetxController{

  RxBool isLoading = false.obs;
  RxBool isUploadingSubmissionPdf = false.obs;

  ///Create Class
  Future createClass(String className, String subjectName) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'className': className,
        'subjectName': subjectName,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}createClass'),
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

  ///Join Class
  Future joinClass(String classCode) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'classCode': classCode,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}joinClass'),
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

  ///Join Class Student
  Future joinClassStudent(String classCode) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'classCode': classCode,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}joinClassStudent'),
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

  ///Post Class Message
  Future postClassMsg(String classCode, String classMsg, bool isAttachment, String attachment, String studentId) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        "classCode": classCode,
        "classMsg": classMsg,
        "isAttachment": isAttachment,
        "attachment": attachment,
        "studentId": studentId
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}classPostMsg'),
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
          print(response.body);
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

  ///Post Msg attachment
  Future<String> getPdfAndUpload() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf']);

    if (result == null) {
      return "No Pdf Selected";
    }

   isLoading.value = true;
    final path = result.files.single.path!;

    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();

    File file = File(path);
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("classPost")
          .child(timestamp);
      UploadTask uploadTask = storageReference.putFile(file);
      String url = await (await uploadTask).ref.getDownloadURL();
      isLoading.value = false;
      return url;
    } on FirebaseException catch (e) {
      isLoading.value = false;
      return "${e.toString()}";
    }
  }

  ///Assignment attachment
  Future<String> getPdfAndUploadAssignment() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf']);

    if (result == null) {
      return "No Pdf Selected";
    }

    isLoading.value = true;
    final path = result.files.single.path!;

    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();

    File file = File(path);
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("Assignment")
          .child(timestamp);
      UploadTask uploadTask = storageReference.putFile(file);
      String url = await (await uploadTask).ref.getDownloadURL();
      isLoading.value = false;
      return url;
    } on FirebaseException catch (e) {
      isLoading.value = false;
      return "${e.toString()}";
    }
  }

  ///Submission attachment
  Future<String> getPdfAndUploadSubmission() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf']);

    if (result == null) {
      return "No Pdf Selected";
    }

    isUploadingSubmissionPdf.value = true;
    final path = result.files.single.path!;

    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();

    File file = File(path);
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("Assignment")
          .child(timestamp);
      UploadTask uploadTask = storageReference.putFile(file);
      String url = await (await uploadTask).ref.getDownloadURL();
      isUploadingSubmissionPdf.value = false;
      return url;
    } on FirebaseException catch (e) {
      isUploadingSubmissionPdf.value = false;
      return "${e.toString()}";
    }
  }

  ///Add Assignment
  Future addAssignment(String classCode, String assignmentName, String assignmentUrl, String fullMarks, String dueDate) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'classCode': classCode,
        'assignmentName': assignmentName,
        'assignmentUrl': assignmentUrl,
        'fullMarks': fullMarks,
        'dueDate': dueDate,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}addAssignment'),
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

  ///Submit Assignment
  Future submitAssignment(String classCode, String assignmentId, String submissionUrl) async {
    isLoading.value = true;
    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'classCode': classCode,
        'assignmentId': assignmentId,
        'submissionUrl': submissionUrl
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}addAssignmentSubmission'),
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
      print("Authentication required");
      return "Authentication required";
    }
  }

  ///Check Assignment Submitted
  Future checkAssignmentSubmitted(String classCode, String assignmentId, String studentId) async {
    isLoading.value = true;
    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'classCode': classCode,
        'assignmentId': assignmentId,
        'studentId': studentId
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}checkIsSubmitted'),
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
        return false;
      }
    }else{
      print("Authentication required");
      return false;
    }
  }

  ///Update Submit Assignment
  Future updateSubmitAssignment(String classCode, String assignmentId, String submissionUrl) async {
    isLoading.value = true;
    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'classCode': classCode,
        'assignmentId': assignmentId,
        'submissionUrl': submissionUrl
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}updateSubmissionUrl'),
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
      print("Authentication required");
      return "Authentication required";
    }
  }

  ///Get User Data
  Future getUserData(String studentId) async {
    isLoading.value = true;
    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'studentId': studentId
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}getUserData'),
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
        return false;
      }
    }else{
      print("Authentication required");
      return false;
    }
  }

  ///Upload  Assignment Marks
  Future uploadMarks(String classCode, String assignmentId, String marksObtained, String studentId) async {
    isLoading.value = true;
    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'classCode': classCode,
        'assignmentId': assignmentId,
        'marksObtained': marksObtained,
        'studentId': studentId
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}updateObtainedMarks'),
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
      print("Authentication required");
      return "Authentication required";
    }
  }

  ///Create Today Class
  Future createAttendance(String classCode) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'classCode': classCode,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}createTodayAttendence'),
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

  /// Add Student to today Class
  Future addStudentTodayAttendence(String classCode, String date) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'classCode': classCode,
        'date': date,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}addAttendenceStudent'),
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

  ///Check already class created
  Future checkAlreadyClassCreated(String classCode) async {
    isLoading.value = true;

    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'classCode': classCode,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}checkClassCreated'),
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

  ///Update  Attendence
  Future updateAttendence(String classCode, String date, String studentId) async {
    isLoading.value = true;
    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'classCode': classCode,
        'date': date,
        'studentId': studentId
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}updateAttendence'),
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
      print("Authentication required");
      return "Authentication required";
    }
  }

  ///Get All Attendence
  Future getAllAttendence(String classCode) async {
    isLoading.value = true;
    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'classCode': classCode,
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}getAllAttendence'),
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
      print("Authentication required");
      return "Authentication required";
    }
  }

  ///Check Individual Attendence
  Future checkIndividualAttendence(String classCode, String date, String studentId) async {
    isLoading.value = true;
    String token = await Apis().getToken();
    if (token != '') {
      final requestBody = {
        'classCode': classCode,
        'date': date,
        'studentId': studentId
      };
      final String requestBodyJson = jsonEncode(requestBody);

      try {
        final response = await http.post(
          Uri.parse('${Constant.baseUrl}getAbsentOrPresent'),
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
      print("Authentication required");
      return "Authentication required";
    }
  }

}