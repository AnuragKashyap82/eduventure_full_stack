import 'dart:io';
import 'package:eduventure_nodejs/Controller/assignment_controller.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/ClassroomApis/classroom_apis.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Model/classroom_model.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';

class AddAssignmentScreen extends StatefulWidget {
  final ClassroomModel classroomModel;

  const AddAssignmentScreen({Key? key, required this.classroomModel})
      : super(key: key);

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  TextEditingController _assNameController = TextEditingController();
  TextEditingController _fullMarksController = TextEditingController();
  ClassroomApis classroomApis = Get.put(ClassroomApis());
  AssignmentController assignmentController = Get.find();

  DateTime selectedDate = DateTime.now();
  String pickedDate = DateTime.now().toIso8601String();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        pickedDate = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  List<String> deviceTokens = [];
  bool _isLodingToken = false;

  // void getDeviceToken()async{
  //   setState(() {
  //     _isLodingToken = true;
  //   });
  //
  //   List<String> allUsersUid = await FireStoreMethods().getAllUsersJoined(widget.classroomModel.classCode);
  //   List<String> userTokens = await FireStoreMethods().getUsersTokens(allUsersUid);
  //
  //   setState(() {
  //     deviceTokens = userTokens;
  //     _isLodingToken = false;
  //   });
  // }
  //
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getDeviceToken();
  // }

  String url = "";

  @override
  Widget build(BuildContext context) {
    // void uploadAss() async {
    //   setState(() {
    //     _isLoading = true;
    //   });
    //   try {
    //     Map<String, dynamic> data = {
    //       'assignmentId': timestamp,
    //       'assignmentName': _assNameController.text,
    //       'classCode': widget.classroomModel.classCode,
    //       'dueDate': pickedDate,
    //       'fullMarks': _fullMarksController.text,
    //       'dateTime': dateTime,
    //       'uid': FirebaseAuth.instance.currentUser?.uid,
    //       'url': url,
    //     };
    //     await reference.set(data).whenComplete(() async{
    //       setState(() {
    //         _isLoading = false;
    //       });
    //       await FireStoreMethods().sendPushNotification(deviceTokens, _assNameController.text, "Assignment: ${widget.classroomModel.subjectName}");
    //       Navigator.pop(context);
    //     });
    //   } catch (e) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //     showSnackBar(e.toString(), context);
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   }
    // }
    //
    // Future getPdfAndUpload() async {
    //   final result = await FilePicker.platform.pickFiles(
    //       allowMultiple: false,
    //       type: FileType.custom,
    //       allowedExtensions: ['pdf']);
    //
    //   if (result == null) {
    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text("No files Selected"),
    //     ));
    //     return null;
    //   }
    //   setState(() {
    //     _isUploading = true;
    //   });
    //   final path = result.files.single.path!;
    //
    //   DateTime time = DateTime.now();
    //   String timestamp = time.millisecondsSinceEpoch.toString();
    //
    //   File file = File(path);
    //   try {
    //     final Reference storageReference =
    //     FirebaseStorage.instance.ref().child("Assignment").child(timestamp);
    //     UploadTask uploadTask = storageReference.putFile(file);
    //     url = await (await uploadTask).ref.getDownloadURL();
    //     showSnackBar(url, context);
    //     setState(() {
    //       _isUploading = false;
    //     });
    //   } on FirebaseException catch (e) {
    //     setState(() {
    //       _isUploading = false;
    //     });
    //     print(e);
    //     showSnackBar(e.toString(), context);
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        centerTitle: true,
        backgroundColor: colorPrimary,
        title: Text(
          "Add Assignment",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: colorBlack),
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.picture_as_pdf_outlined),
            ),
            onTap: () async {
              url = await classroomApis.getPdfAndUploadAssignment();
              showSnackBar(url, context);
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(26),
        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: [
            TextField(
              controller: _assNameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autofocus: false,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.assignment_outlined,
                  color: colorPrimary,
                ),
                hintText: "Assignment Name",
                filled: true,
                fillColor: gray02,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _fullMarksController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autofocus: false,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.book_online_outlined,
                  color: colorPrimary,
                ),
                hintText: "Full Marks",
                fillColor: gray02,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(color: gray02),
                    color: gray02),
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.calendar_month_outlined,
                        color: colorPrimary,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          pickedDate,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: colorBlack),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Obx(() {
              return Container(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_isLodingToken) {
                      showSnackBar(
                          "You have slow Network Connection. Please Wait and Click again!!!",
                          context);
                    } else {
                      if (url == "") {
                        showSnackBar("Please Pick Pdf", context);
                      } else {
                        if (_assNameController.text.isEmpty) {
                          showSnackBar("Enter Ass Name", context);
                        } else if (_fullMarksController.text.isEmpty) {
                          showSnackBar("Enter Full Marks No", context);
                        } else if (pickedDate == "") {
                          showSnackBar("Enter Full Marks No", context);
                        } else {
                          final message = await classroomApis.addAssignment(
                            widget.classroomModel.classCode,
                            _assNameController.text.trim(),
                            url,
                            _fullMarksController.text.trim(),
                            pickedDate,
                          );
                          if (message['status']) {
                            showSnackBar("Assignment Uploaded", context);
                            await assignmentController.fetchAssignment(widget.classroomModel.classCode);
                          } else {
                            showSnackBar(message['msg'].toString(), context);
                          }
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      elevation: 0,
                      backgroundColor: colorPrimary),
                  child: classroomApis.isLoading.value
                      ? CircularProgressIndicator(
                    color: colorWhite,
                    strokeWidth: 2,
                  )
                      : Text(
                    'Upload',
                    style: TextStyle(color: colorWhite),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
