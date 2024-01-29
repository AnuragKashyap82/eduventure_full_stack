import 'dart:io';
import 'package:eduventure_nodejs/Controller/result_controller.dart';
import 'package:eduventure_nodejs/screens/ResultScreen/result_apis/result_apis.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';
import '../../utils/global_variables.dart';

class AddResultScreen extends StatefulWidget {
  const AddResultScreen({Key? key}) : super(key: key);

  @override
  State<AddResultScreen> createState() => _AddResultScreenState();
}
class _AddResultScreenState extends State<AddResultScreen> {
  ResultApis resultApis = Get.put(ResultApis());
  ResultController resultController = Get.find();
  TextEditingController _resultYear = TextEditingController();

  String semester = "Select Your Semester";
  String branch = "Select Your branch";
  File? file;
  String url = "";



  List<String> deviceTokens = [];
  bool _isLodingToken = false;

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


  @override
  Widget build(BuildContext context) {

    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();

    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String dateTime = date;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
         
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.attach_file),
            ),
            onTap: ()  async{
              url =  await resultApis.getPdfAndUpload(timestamp);
            },
          )
        ],
        title: Text("Add Result Screen",style: TextStyle(fontSize: 16, color: colorBlack, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.all(26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 52,
                child: Center(
                  child: TextField(
                    controller: _resultYear,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month_outlined, color: colorPrimary,),
                      hintText: "Result Year",
                      filled: true,
                      fillColor: gray02,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: colorWhite,
                          surfaceTintColor: colorWhite,
                          alignment: Alignment(0.0, 0.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                20.0,
                              ),
                            ),
                          ),
                          contentPadding: EdgeInsets.only(
                              top: 4.0, bottom: 4
                          ),
                          insetPadding:
                          EdgeInsets.symmetric(horizontal: 0),
                          content: Container(
                            constraints: BoxConstraints(maxHeight: 350),
                            width: 320,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 12,
                                  ),
                                  const Text(
                                    "Select Your Semester",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "1st Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child:  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "1st Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "2nd Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "2nd Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "3rd Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "3rd Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "4th Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "4th Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "5th Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child:Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "5th Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "6th Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "6th Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "7th Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "7th Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "8th Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "8th Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: gray02),
                      color: gray02),
                  child: Center(
                    child: Text(
                      "${semester}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: colorWhite,
                          surfaceTintColor: colorWhite,
                          alignment: Alignment(0.0, 0.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                20.0,
                              ),
                            ),
                          ),
                          contentPadding: EdgeInsets.only(
                              top: 4.0, bottom: 4
                          ),
                          insetPadding:
                          EdgeInsets.symmetric(horizontal: 0),
                          content: Container(
                              width: 320,
                              child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Select Your branch",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            branch = "CSE";
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                          child: Container(
                                            height: 52,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: gray02,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "CSE",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            branch = "ME";
                                          });
                                          Navigator.pop(context);
                                        },
                                        child:Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                          child: Container(
                                            height: 52,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: gray02,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "ME",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            branch = "ECE";
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                          child: Container(
                                            height: 52,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: gray02,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "ECE",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            branch = "EE";
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                          child: Container(
                                            height: 52,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: gray02,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "EE",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            branch = "CE";
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                          child: Container(
                                            height: 52,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: gray02,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "CE",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ))),
                        );
                      });
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: gray02),
                      color: gray02),
                  child: Center(
                    child: Text(
                      "${branch}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 26,
              ),
              Obx(() {
                return  Container(
                  height: 52,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async{
                        if(_isLodingToken){
                          showSnackBar("You have slow Network Connection. Please Wait and Click again!!!", context);
                        }else{
                          if (semester == "Select Your Semester") {
                            showSnackBar("Select Your Semester", context);
                          } else if(branch == "Select Your branch") {
                            showSnackBar("Select Your branch", context);
                          }else if(url == ""){
                            showSnackBar("Pick Result PDF", context);
                          }else if(_resultYear.text.isEmpty){
                            showSnackBar("Enter Result Year", context);
                          }else{
                            final message = await resultApis.uploadResult(branch, semester, url, _resultYear.text.trim());
                            if(message['status']){
                              showSnackBar("Result Uploaded", context);
                              resultController.fetchResults(semester, branch);
                            }else{
                              showSnackBar(message['msg'].toString(), context);
                            }
                          }
                        }

                      },
                      style: ElevatedButton.styleFrom(shape: StadiumBorder(), elevation: 0, backgroundColor: colorPrimary),
                      child: resultApis.isLoading.value
                          ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorWhite,
                        ),
                      )
                          : Text("Upload Result", style: TextStyle(color: colorWhite),)),
                );
              })

            ],
          ),
        ),
      ),
    );
  }
}
