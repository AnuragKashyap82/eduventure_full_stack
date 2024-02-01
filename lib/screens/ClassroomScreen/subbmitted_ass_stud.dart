import 'package:eduventure_nodejs/Controller/submission_controller.dart';
import 'package:eduventure_nodejs/Model/class_ass_model.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/submitted_ass_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import 'Widgets/submitted_ass_card.dart';

class SubmittedAssStudent extends StatefulWidget {
  final AssignmentModel assignmentModel;

  const SubmittedAssStudent({Key? key, required this.assignmentModel})
      : super(key: key);

  @override
  State<SubmittedAssStudent> createState() => _SubmittedAssStudentState();
}

class _SubmittedAssStudentState extends State<SubmittedAssStudent> {
  SubmissionController submissionController = Get.put(SubmissionController());

  Future<void> getAllName() async {
    await submissionController.fetchAssignment(widget.assignmentModel.classCode,
        "${widget.assignmentModel.assignmentId}");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Call getAllName() after the widget has been built
      getAllName();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        title: Text(
          "Submitted Name",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: colorBlack),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (submissionController.isLoading.value)
          return Center(
            child:
                CircularProgressIndicator(strokeWidth: 2, color: colorPrimary),
          );
        if (submissionController.allSubmission.isEmpty) {
          return Center(
            child: Text(
              "No Submission",
              style: TextStyle(
                fontSize: 14,
                color: colorBlack,
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: submissionController.allSubmission.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            final submission = submissionController.allSubmission[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubmittedAssViewScreen(
                              submissionModel: submission,
                            )));
              },
              child: SubmittedAssCard(
                submissionModel: submission,
              ),
            );
          },
        );
      }),
    );
  }
}
