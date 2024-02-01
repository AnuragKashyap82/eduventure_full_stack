
import 'package:eduventure_nodejs/Model/submission_model.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/ClassroomApis/classroom_apis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';

class SubmittedAssCard extends StatefulWidget {
  final SubmissionModel submissionModel;

  const SubmittedAssCard({Key? key, required this.submissionModel}) : super(key: key);

  @override
  State<SubmittedAssCard> createState() => _SubmittedAssCardState();
}

class _SubmittedAssCardState extends State<SubmittedAssCard> {
  ClassroomApis classroomApis = Get.put(ClassroomApis());

  var studentData;
  bool _isLoading = false;

  Future<void> getUserData() async{
    setState(() {
      _isLoading = true;
    });
    final studentDat = await classroomApis.getUserData(widget.submissionModel.studentId);
    setState(() {
      studentData = studentDat['student'];
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Call getAllName() after the widget has been built
      getUserData();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child:
      Obx(() {
        if(classroomApis.isLoading.value){
          return Center(child: CircularProgressIndicator(strokeWidth: 2, color: colorPrimary,));
        }
        return _isLoading?Center(child: CircularProgressIndicator(strokeWidth: 2, color: colorPrimary,)):Container(
          width: 600,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: colorWhite, ),
            borderRadius: BorderRadius.circular(12),
            color: gray02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                leading: studentData['photoUrl'] != null?CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      studentData['photoUrl']),
                ):CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person_pin, color: colorPrimary,),
                ),
                title: Text(
                  studentData['name'] != null?
                  "${studentData['name']}" : "",
                  style: TextStyle(
                    fontSize: 14,
                    color: colorBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${widget.submissionModel.marksObtained}/${widget.submissionModel.fullMarks}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing:  Text(
                  widget.submissionModel.dateTime,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        );
      })
    );
  }
}
