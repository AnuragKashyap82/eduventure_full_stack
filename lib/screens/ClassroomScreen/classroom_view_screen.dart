import 'package:eduventure_nodejs/Controller/assignment_controller.dart';
import 'package:eduventure_nodejs/Controller/class_post_msg_controller.dart';
import 'package:eduventure_nodejs/Controller/user_controller.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/Widgets/class_post_msg_card.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/post_msg_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Model/classroom_model.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import 'assignment_screen.dart';
import 'attendance_screen.dart';
import 'class_msg_view_screen.dart';

class ClassroomViewScreen extends StatefulWidget {
  final ClassroomModel classroomModel;

  const ClassroomViewScreen({
    Key? key,
    required this.classroomModel,
  }) : super(key: key);

  @override
  State<ClassroomViewScreen> createState() => _ClassroomViewScreenState();
}

class _ClassroomViewScreenState extends State<ClassroomViewScreen> {
  UserController userController = Get.find();

  ClassroomPostMsgController postMsgController = Get.put(ClassroomPostMsgController());
  AssignmentController assignmentController = Get.put(AssignmentController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Anurag ${widget.classroomModel.classCode}");
    postMsgController.fetchClassrooms(widget.classroomModel.classCode);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        centerTitle: true,
        backgroundColor: colorPrimary,
        title: Text(
          widget.classroomModel.subjectName,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: colorBlack),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child:
            Obx(() {
              if (postMsgController.isLoading.value)
                return Center(
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: colorPrimary),
                );
              if (postMsgController.allClassroomsMsg.isEmpty) {
                return Center(
                  child: Text(
                    "No Message",
                    style: TextStyle(
                      fontSize: 14,
                      color: colorBlack,
                    ),
                  ),
                );
              }
              return ListView.builder(
                  itemCount: postMsgController.allClassroomsMsg.length,
                  itemBuilder: (context, index) {
                    final classroomMsg =
                        postMsgController.allClassroomsMsg[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ClassMsgViewScreen(
                              postMsgModel: classroomMsg,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: width > webScreenSize ? width * 0.3 : 0,
                          vertical: width > webScreenSize ? 15 : 0,
                        ),
                        child: ClassPostMsgCard(
                          postMsgModel: classroomMsg,
                        ),
                      ),
                    );
                  });
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8)
                .copyWith(top: 0),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: colorPrimary, borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.video_call,
                      color: colorBlack,
                    ),
                    onPressed: () {
                      showSnackBar("To be integrated!!!", context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.assignment_outlined,
                      color: colorBlack,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AssignmentScreen(
                            classroomModel: widget.classroomModel,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit_outlined, color: colorBlack),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClassroomPostMsgScreen(
                            classroomModel: widget.classroomModel,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.mark_as_unread, color: colorBlack),
                    onPressed: () {
                      userController.userData().studentId == widget.classroomModel.studentId?
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AttendanceScreen(
                            classroomModel: widget.classroomModel,
                          ),
                        ),
                      ):
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MyAttendenceReportScreen(
                      //       classroomModel: widget.classroomModel,
                      //     ),
                      //   ),
                      // );
                      showSnackBar("To be integrated", context);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
