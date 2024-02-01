import 'package:eduventure_nodejs/Model/student_model.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/ClassroomApis/classroom_apis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';

class StudentWidgets extends StatefulWidget {
  final StudentModel studentModel;
  final String classCode;
  final String date;

  const StudentWidgets(
      {Key? key,
      required this.studentModel,
      required this.classCode,
      required this.date})
      : super(key: key);

  @override
  State<StudentWidgets> createState() => _StudentWidgetsState();
}

class _StudentWidgetsState extends State<StudentWidgets> {
  String absentPresent = "";
  ClassroomApis classroomApis = Get.put(ClassroomApis());

  Future<void> init() async {
    final message = await classroomApis.checkIndividualAttendence(widget.classCode, widget.date, widget.studentModel.studentId);
    if (message['status']) {
      if( message['attendence'] == "absent"){
        setState(() {
          absentPresent = "A";
        });
      }else{
        setState(() {
          absentPresent = "P";
        });
      }
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: gray02,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.studentModel.name,
                      style: TextStyle(
                          fontSize: 16,
                          color: colorBlack,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.studentModel.studentId,
                      style: TextStyle(
                          fontSize: 12,
                          color: colorBlack.withOpacity(0.54),
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    final message = await classroomApis.updateAttendence(
                        widget.classCode, widget.date, widget.studentModel.studentId);
                    if (message['status']) {
                      init();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: PhysicalModel(
                      color: colorWhite,
                      elevation: 7,
                      shadowColor: colorPrimary,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: colorBlack.withOpacity(0.54))),
                        child: Center(
                            child: Text(
                          absentPresent,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: absentPresent == "P"
                                  ? Colors.green
                                  : Colors.red),
                        )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
