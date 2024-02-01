import 'package:eduventure_nodejs/Controller/student_controller.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/ClassroomApis/classroom_apis.dart';
import 'package:eduventure_nodejs/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Model/classroom_model.dart';
import '../../utils/colors.dart';
import 'Widgets/students_widgets.dart';

class AttendanceScreen extends StatefulWidget {
  final ClassroomModel classroomModel;

  const AttendanceScreen({Key? key, required this.classroomModel})
      : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  StudentController studentController = Get.put(StudentController());
  ClassroomApis classroomApis = Get.put(ClassroomApis());

  bool _isInit = false;
  bool _isClassCreated = false;
  String date = "";

  Future<void> initFunction()async{
    final message  = await classroomApis.checkAlreadyClassCreated(widget.classroomModel.classCode);
    if(message['status']){
      setState(() {
        _isClassCreated = true;
        date = message['date'];
      });
    }else{
      setState(() {
        _isClassCreated = false;
        date = message['date'];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFunction();
    studentController.fetchStudent(widget.classroomModel.classCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text(
          widget.classroomModel.subjectName,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: _isInit
          ? Center(
              child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colorPrimary,
            ))
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.classroomModel.className}",
                      style: TextStyle(
                          fontSize: 16,
                          color: colorBlack,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Obx(() {
                      return Text(
                        "Total No Of Students: ${studentController.allStudent.length}",
                        style: TextStyle(
                            fontSize: 14,
                            color: colorBlack,
                            fontWeight: FontWeight.normal),
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 52,
                          width: MediaQuery.of(context).size.width / 2 - 32,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) => ReportScreen(
                              //               classroomModel:
                              //                   widget.classroomModel,
                              //             )));
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: colorPrimary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            child: const Text(
                              "Report",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        !_isClassCreated
                            ?
                       Obx(() {
                         return  SizedBox(
                           height: 52,
                           width:
                           MediaQuery.of(context).size.width / 2 - 32,
                           child: ElevatedButton(
                               onPressed: () async {
                                 final message = await classroomApis.createAttendance(widget.classroomModel.classCode);
                                 if(message['status']){
                                   final messagess = await classroomApis.addStudentTodayAttendence(widget.classroomModel.classCode, date);
                                   if(messagess['status']){
                                     await studentController.fetchStudent(widget.classroomModel.classCode);
                                     setState(() {
                                       _isClassCreated = true;
                                     });
                                   }else{
                                     showSnackBar("${messagess['msg']}", context);
                                   }
                                 }else{
                                   showSnackBar("${message['msg']}", context);
                                 }
                               },
                               style: ElevatedButton.styleFrom(
                                   elevation: 0,
                                   backgroundColor: colorPrimary,
                                   shape: RoundedRectangleBorder(
                                       borderRadius:
                                       BorderRadius.circular(12))),
                               child: classroomApis.isLoading.value
                                   ? CircularProgressIndicator(
                                 color: colorWhite,
                                 strokeWidth: 2,
                               )
                                   : const Text(
                                 "Create Attendance",
                                 textAlign: TextAlign.center,
                                 style:
                                 TextStyle(color: Colors.black),
                               )),
                         );
                       })
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _isClassCreated
                        ? Obx(() {
                            if (studentController.isLoading.value)
                              return Center(
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: colorPrimary),
                              );
                            if (studentController.allStudent.isEmpty) {
                              return Center(
                                child: Text(
                                  "No Student",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colorBlack,
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: studentController.allStudent.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (_, index) {
                                final student =
                                    studentController.allStudent[index];
                                return StudentWidgets(
                                  studentModel: student,
                                  classCode: widget.classroomModel.classCode,
                                  date: date
                                );
                              },
                            );
                          })
                        : Center(
                            child: Container(
                              child: Text(
                                "No Class Created!!!!",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colorBlack,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
