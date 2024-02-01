import 'package:eduventure_nodejs/Controller/submission_controller.dart';
import 'package:eduventure_nodejs/Controller/user_controller.dart';
import 'package:eduventure_nodejs/Model/class_ass_model.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/ClassroomApis/classroom_apis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';

class AssignmentCard extends StatefulWidget {
  final AssignmentModel assignmentModel;

  const AssignmentCard({Key? key, required this.assignmentModel})
      : super(key: key);

  @override
  State<AssignmentCard> createState() => _AssignmentCardState();
}

class _AssignmentCardState extends State<AssignmentCard> {
  UserController userController = Get.find();
  SubmissionController submissionController = Get.find();
  ClassroomApis classroomApis = Get.put(ClassroomApis());
  bool isAlreadySubmitted = false;

  Future<void> checkAssignmentSubmitted() async {
    final message =  await classroomApis.checkAssignmentSubmitted(widget.assignmentModel.classCode, "${widget.assignmentModel.assignmentId}", userController.userData().studentId);
    print("Submitted value: ${message['status']}\n");
    if(message['status']){
      setState(() {
        isAlreadySubmitted = true;
      });
    }else{

    }

  }

  @override
  void initState() {
    super.initState();
    checkAssignmentSubmitted();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            color: gray02, borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          leading: Obx(() {
            return submissionController.isLoading.value
                ? CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colorPrimary,
                  )
                : Icon(
                    Icons.assignment,
                    color: isAlreadySubmitted ? Colors.grey : colorPrimary,
                  );
          }),
          title: Text(
            widget.assignmentModel.assignmentName,
            style: TextStyle(color: colorBlack, fontSize: 16),
          ),
          subtitle: Text(
            "Teacher Name",
            style: TextStyle(color: colorBlack.withOpacity(0.5), fontSize: 14),
          ),
          trailing: Text(
            "${widget.assignmentModel.dueDate}\n${widget.assignmentModel.dateTime}",
            style: TextStyle(
                color: colorBlack, fontWeight: FontWeight.w500, fontSize: 14),
            textAlign: TextAlign.end,
          ),
        ),
      ),
    );
  }
}
