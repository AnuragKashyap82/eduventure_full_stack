import 'dart:io';
import 'package:eduventure_nodejs/Controller/user_controller.dart';
import 'package:eduventure_nodejs/Model/class_ass_model.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/ClassroomApis/classroom_apis.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/subbmitted_ass_stud.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/your_submitted_ass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

import '../../Controller/submission_controller.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';

class AssignmentViewScreen extends StatefulWidget {
  final AssignmentModel assignmentModel;

  const AssignmentViewScreen({Key? key, required this.assignmentModel})
      : super(key: key);

  @override
  State<AssignmentViewScreen> createState() => _AssignmentViewScreenState();
}

class _AssignmentViewScreenState extends State<AssignmentViewScreen> {
  late PdfController pdfController;
  late PageController pageController;
  int _currentPage = 0;
  int totalPages = 0;
  bool _isLoading = false;
  UserController userController = Get.find();
  ClassroomApis classroomApis = Get.put(ClassroomApis());

  Future<void> loadController() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final pdfData = await InternetFile.get(widget.assignmentModel.assignmentUrl);
      pdfController = PdfController(
        document: PdfDocument.openData(pdfData),
      );
      totalPages = (await pdfController.pagesCount)!;
      print("Anuragd $totalPages");
    } catch (e) {
      // Handle error loading PDF, you can show an error message or take appropriate action
      print('Error loading PDF: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  SubmissionController submissionController = Get.find();

  bool isAlreadySubmitted = false;
  var submissionResponse;

  Future<void> checkAssignmentSubmitted() async {
    final message =  await classroomApis.checkAssignmentSubmitted(widget.assignmentModel.classCode, "${widget.assignmentModel.assignmentId}", userController.userData().studentId);
    print("Submitted value: ${message['status']}\n");
    if(message['status']){
      print(message);
      setState(() {
        isAlreadySubmitted = true;
        submissionResponse = message['submission'];
      });
    }else{

    }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadController();
    checkAssignmentSubmitted();
  }

  String url = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        centerTitle: true,
        backgroundColor: colorPrimary,
        title: Text(
          widget.assignmentModel.assignmentName,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: colorBlack),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  useRootNavigator: true,
                  backgroundColor: colorWhite,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26))),
                  context: context,
                  builder: (context) => Container(
                        height: 370,
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                    child: Text(
                                  "Your Work",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                                Text(
                                  widget.assignmentModel.dueDate,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                isAlreadySubmitted
                                    ? const Expanded(
                                        child: Text(
                                        "Completed",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ))
                                    : const Expanded(
                                        child: Text(
                                        "Not yet Completed",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent),
                                      )),
                                Obx(() {
                                  return GestureDetector(
                                      onTap: () async {
                                        url = await classroomApis.getPdfAndUploadSubmission();
                                      },
                                      child: classroomApis
                                              .isUploadingSubmissionPdf.value
                                          ? CircularProgressIndicator(
                                              color: colorPrimary,
                                              strokeWidth: 2,
                                            )
                                          : const Icon(
                                              Icons.picture_as_pdf_outlined));
                                }),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${submissionResponse['marksObtained']}/${submissionResponse['fullMarks']}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Obx(() {
                              return Offstage(
                                offstage: isAlreadySubmitted,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 46,
                                  child: ElevatedButton(
                                    onPressed: () async{
                                      if (url == "") {
                                        showSnackBar("Please select your ass pdf", context);
                                      } else {
                                        final message = await classroomApis.submitAssignment(widget.assignmentModel.classCode, "${widget.assignmentModel.assignmentId}", url);
                                        if(message['status']){
                                          showSnackBar("Assignment Submitted", context);
                                          await submissionController.fetchAssignment(widget.assignmentModel.classCode, "${widget.assignmentModel.assignmentId}");
                                          await checkAssignmentSubmitted();
                                        }else{
                                          showSnackBar(message['msg'].toString(), context);
                                        }
                                      }
                                    },
                                    child: classroomApis.isLoading.value?CircularProgressIndicator(color: colorBlack, strokeWidth: 2,):Text(
                                      "+Add Work",
                                      style: TextStyle(color: colorWhite),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        elevation: 0,
                                        backgroundColor: colorPrimary),
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(
                              height: 8,
                            ),
                            Obx(() {
                              return Offstage(
                                offstage: !isAlreadySubmitted,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 46,
                                  child: ElevatedButton(
                                    onPressed: () async{
                                      if (url == "") {
                                        showSnackBar("Please select your ass pdf",
                                            context);
                                      } else {
                                        final message = await classroomApis.updateSubmitAssignment(widget.assignmentModel.classCode, "${widget.assignmentModel.assignmentId}", url);
                                        if(message['status']){
                                          showSnackBar("Assignment Updated", context);
                                          await submissionController.fetchAssignment(widget.assignmentModel.classCode, "${widget.assignmentModel.assignmentId}");
                                          await checkAssignmentSubmitted();
                                        }else{
                                          showSnackBar(message['msg'].toString(), context);
                                        }
                                      }
                                    },
                                    child: classroomApis.isLoading.value?CircularProgressIndicator(color: colorBlack, strokeWidth: 2,):Text(
                                      "Replace your work",
                                      style: TextStyle(color: colorWhite),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        elevation: 0,
                                        backgroundColor: colorPrimary),
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(
                              height: 8,
                            ),
                            Offstage(
                              offstage: !isAlreadySubmitted,
                              child: SizedBox(
                                width: double.infinity,
                                height: 46,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => YourSubmittedAss(snap: submissionResponse)));
                                  },
                                  child: Text(
                                    "Your work",
                                    style: TextStyle(color: colorWhite),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      elevation: 0,
                                      backgroundColor: colorPrimary),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            userController.userData().userType == "teacher"
                                ? SizedBox(
                                    width: double.infinity,
                                    height: 46,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SubmittedAssStudent(assignmentModel: widget.assignmentModel)));
                                      },
                                      child: Text(
                                        "Students Works",
                                        style: TextStyle(color: colorWhite),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          elevation: 0,
                                          backgroundColor: colorPrimary),
                                    ),
                                  )
                                : userController.userData().userType == "admin"
                                    ? SizedBox(
                                        width: double.infinity,
                                        height: 46,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => SubmittedAssStudent(assignmentModel: widget.assignmentModel)));
                                          },
                                          child: Text(
                                            "Students Works",
                                            style: TextStyle(color: colorWhite),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              shape: const StadiumBorder(),
                                              elevation: 0,
                                              backgroundColor: colorPrimary),
                                        ),
                                      )
                                    : const SizedBox(),
                          ],
                        ),
                      ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.upload_file_outlined,
                color: colorBlack,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator(
          strokeWidth: 2,
          color: colorPrimary,
        )
            : PdfView(
          controller: pdfController,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              _currentPage = page;
            });
          },
        ),
      ),
      floatingActionButton: SpeedDial(
        direction: SpeedDialDirection.up,
        icon: Icons.add,
        //icon on Floating action button
        activeIcon: Icons.close,
        //icon when menu is expanded on button
        backgroundColor: colorPrimary,
        //background color of button
        foregroundColor: colorWhite,
        //font color, icon color in button
        activeBackgroundColor: colorPrimary,
        //background color when menu is expanded
        activeForegroundColor: colorWhite,
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: colorBlack,
        overlayOpacity: 0.1,
        elevation: 12.0,

        //shadow elevation of button
        shape: const CircleBorder(),
        //shape of button

        children: [
          userController.userData().userType == "teacher"
              ? SpeedDialChild(
                  //speed dial child
                  child: const Icon(Icons.edit_outlined),
                  backgroundColor: colorPrimary,
                  foregroundColor: colorWhite,
                  onTap: () {
                    showSnackBar("Teacher", context);
                  },
                )
              : userController.userData().userType == "admin"
                  ? SpeedDialChild(
                      //speed dial child
                      child: const Icon(Icons.edit_outlined),
                      backgroundColor: colorPrimary,
                      foregroundColor: colorWhite,
                      onTap: () {
                        showSnackBar("Teacher", context);
                      },
                    )
                  : SpeedDialChild(),

          userController.userData().userType == "teacher"
              ? SpeedDialChild(
                  //speed dial child
                  child: const Icon(Icons.delete_outline),
                  backgroundColor: colorPrimary,
                  foregroundColor: colorWhite,
                  onTap: () {},
                )
              : userController.userData().userType == "admin"
                  ? SpeedDialChild(
                      //speed dial child
                      child: const Icon(Icons.delete_outline),
                      backgroundColor: colorPrimary,
                      foregroundColor: colorWhite,
                      onTap: () {},
                    )
                  : SpeedDialChild(),

          SpeedDialChild(
            child: const Icon(Icons.download_outlined),
            backgroundColor: colorPrimary,
            foregroundColor: colorWhite,
            onTap: () {},
          ),

          //add more menu item children here
        ],
      ),
    );
  }
}
