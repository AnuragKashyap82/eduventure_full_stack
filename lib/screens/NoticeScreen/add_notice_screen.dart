import 'dart:io';
import 'package:eduventure_nodejs/Controller/user_controller.dart';
import 'package:eduventure_nodejs/screens/NoticeScreen/notice_apis/notice_apis.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../Controller/notice_controller.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';

class AddNoticeScreen extends StatefulWidget {
  const AddNoticeScreen({Key? key}) : super(key: key);

  @override
  State<AddNoticeScreen> createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {
  TextEditingController _noticeTitle = TextEditingController();
  TextEditingController _noticeNo = TextEditingController();

  NoticeController noticeController = Get.find();
  UserController userController = Get.find();
  NoticeApis noticeApis = Get.put(NoticeApis());

  List<String> deviceTokens = [];
  bool _isLodingToken = false;

  @override
  void dispose() {
    super.dispose();
    _noticeNo.dispose();
    _noticeNo.dispose();
  }



  // void getDeviceToken()async{
  //   setState(() {
  //     _isLodingToken = true;
  //   });
  //   List<String> allTokens = await FireStoreMethods().getAllUsersToken();
  //   setState(() {
  //     deviceTokens = allTokens;
  //     _isLodingToken = false;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDeviceToken();
  }

  UploadTask? task;
  File? file;
  String url = "";

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();

    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String dateTime = date;
    String tDate = DateFormat("HH:mm").format(DateTime.now());



    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorPrimary,
        iconTheme: IconThemeData(color: colorBlack),
        title: Text(
          "Add Notice",
          style: TextStyle(
              fontSize: 16, color: colorBlack, fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.attach_file),
            ),
            onTap: () async{
             url =  await noticeApis.getPdfAndUpload(timestamp);
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(26),
        margin: EdgeInsets.only(top: 100),
        child: SizedBox(
          child: Column(
            children: [
              TextField(
                controller: _noticeTitle,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.line_axis, color: colorPrimary,),
                  hintText: "Notice Title",
                  filled: true,
                  fillColor: gray02,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: _noticeNo,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.line_axis, color: colorPrimary,),
                  hintText: "Notice No",
                  fillColor: gray02,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Obx(() {
                return Container(
                  height: 52,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async{
                      if(_isLodingToken){
                        showSnackBar("Please wait", context);
                      }else{
                        if (url == "") {
                          showSnackBar("Please Pick Pdf", context);
                        } else {
                          if (_noticeTitle.text.isEmpty) {
                            showSnackBar("Enter Notice Title", context);
                          } else if (_noticeNo.text.isEmpty) {
                            showSnackBar("Enter Notice No", context);
                          } else {
                            final message = await noticeApis.uploadNotice(_noticeNo.text.trim(), _noticeTitle.text.trim(), url);
                            if(message['status']){
                              showSnackBar("Notice Uploaded", context);
                              noticeController.fetchNotices();
                            }else{
                              showSnackBar(message['msg'].toString(), context);
                            }

                          }
                        }
                      }

                    },
                    style: ElevatedButton.styleFrom(shape: StadiumBorder(), elevation: 0, backgroundColor: colorPrimary),
                    child: noticeApis.isLoading.value
                        ? CircularProgressIndicator(
                      color: colorWhite,
                      strokeWidth: 2,
                    )
                        :  Text("Upload Notice", style: TextStyle(color: colorWhite),),
                  ),
                );
              })

            ],
          ),
        ),
      ),
    );
  }
}
