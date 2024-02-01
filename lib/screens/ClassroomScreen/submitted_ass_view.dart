import 'package:eduventure_nodejs/Controller/submission_controller.dart';
import 'package:eduventure_nodejs/Model/submission_model.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/ClassroomApis/classroom_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

import '../../utils/colors.dart';
import '../../utils/global_variables.dart';

class SubmittedAssViewScreen extends StatefulWidget {
  final SubmissionModel submissionModel;

  const SubmittedAssViewScreen({Key? key, required this.submissionModel})
      : super(key: key);

  @override
  State<SubmittedAssViewScreen> createState() => _SubmittedAssViewScreenState();
}

class _SubmittedAssViewScreenState extends State<SubmittedAssViewScreen> {
  bool _isLoading = false;
  TextEditingController _obtainedMarks = TextEditingController();
  ClassroomApis classroomApis = Get.put(ClassroomApis());
  SubmissionController submissionController = Get.find();

  late PdfController pdfController;

  loadController() {
    pdfController = PdfController(
      document: PdfDocument.openData(
          InternetFile.get(widget.submissionModel.submissionUrl)),
    );
  }

  @override
  void initState() {
    super.initState();
    loadController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: colorPrimary,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        title: Text(
          widget.submissionModel.assignmentName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colorBlack,
          ),
        ),
      ),
      body: PdfView(
        controller: pdfController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            context: context,
            builder: (context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                      Expanded(
                        child: Text(
                          "Obtained Marks",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: colorPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Provide marks to this student according to their submitted Assignment",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: _obtainedMarks,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.assignment_outlined),
                      hintText: "Enter Obtained Marks",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: colorPrimary),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorPrimary),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorPrimary),
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Obx(() {
                    return SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_obtainedMarks.text.isEmpty) {
                            showSnackBar("Enter Marks Obtained", context);
                          } else {
                            final message = await classroomApis.uploadMarks(
                                widget.submissionModel.classCode,
                                widget.submissionModel.assignmentId,
                                _obtainedMarks.text.trim(),
                                widget.submissionModel.studentId);
                            await submissionController.fetchAssignment(widget.submissionModel.classCode, widget.submissionModel.assignmentId);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            elevation: 0,
                            backgroundColor: colorPrimary),
                        child: classroomApis.isLoading.value
                            ? CircularProgressIndicator(
                          color: colorBlack,
                          strokeWidth: 2,
                        )
                            : Text(
                          "Submit",
                          style: TextStyle(color: colorWhite),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.edit_note_outlined),
      ),
    );
  }
}
