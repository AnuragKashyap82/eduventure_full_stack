import 'package:eduventure_nodejs/Controller/assignment_controller.dart';
import 'package:eduventure_nodejs/Controller/submission_controller.dart';
import 'package:eduventure_nodejs/Controller/user_controller.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/Widgets/assignment_card.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/ass_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Model/classroom_model.dart';
import '../../utils/colors.dart';
import 'ClassroomApis/classroom_apis.dart';
import 'add_ass_screen.dart';

class AssignmentScreen extends StatefulWidget {
  final ClassroomModel classroomModel;

  const AssignmentScreen({Key? key, required this.classroomModel})
      : super(key: key);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  ClassroomApis classroomApis = Get.put(ClassroomApis());
  SubmissionController submissionController = Get.put(SubmissionController());
  UserController userController = Get.find();
  AssignmentController assignmentController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignmentController.fetchAssignment(widget.classroomModel.classCode);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        centerTitle: true,
        backgroundColor: colorPrimary,
        title: Text(
          "Assignment Section",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: colorBlack),
        ),
      ),
      body:
      Obx(() {
        if (assignmentController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
                strokeWidth: 2, color: colorPrimary),
          );
        }
        if (assignmentController.allAssignment.isEmpty) {
          return Center(
            child: Text(
              "No Assignment",
              style: TextStyle(
                fontSize: 14,
                color: colorBlack,
              ),
            ),
          );
        }
        return ListView.builder(
            itemCount: assignmentController.allAssignment.length,
            itemBuilder: (context, index) {
              final assignment = assignmentController.allAssignment[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AssignmentViewScreen(
                      assignmentModel: assignment
                  )));
                },
                child: AssignmentCard(
                  assignmentModel: assignment,
                ),
              );
            });
      }),
      floatingActionButton: userController.userData().userType == "teacher"
          ? FloatingActionButton(
              backgroundColor: colorPrimary,
              shape: StadiumBorder(),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddAssignmentScreen(classroomModel: widget.classroomModel)));
              },
              child: Icon(
                Icons.add,
                color: colorBlack,
              ),
            )
          : userController.userData().userType == "admin"
              ? FloatingActionButton(
                  backgroundColor: colorPrimary,
                  shape: StadiumBorder(),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddAssignmentScreen(classroomModel: widget.classroomModel)));
                  },
                  child: Icon(
                    Icons.add,
                    color: colorBlack,
                  ),
                )
              : SizedBox(),
    );
  }
}
