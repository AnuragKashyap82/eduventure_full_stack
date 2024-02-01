import 'dart:developer';
import 'package:eduventure_nodejs/Controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../Model/classroom_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/global_variables.dart';

class ClassroomCard extends StatefulWidget {
  final ClassroomModel  classroomModel;

  const ClassroomCard({
    Key? key,
    required this.classroomModel,
  }) : super(key: key);

  @override
  State<ClassroomCard> createState() => _ClassroomCardState();
}

class _ClassroomCardState extends State<ClassroomCard> {

  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    log("Clkassroom");

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: gray02),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.classroomModel.subjectName,
                      style: TextStyle(
                          fontSize: 16,
                          color: colorBlack,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              backgroundColor: colorWhite,
                              surfaceTintColor: colorWhite,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: ListView(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16),
                                shrinkWrap: true,
                                children: [
                                  'UnEnroll',
                                ]
                                    .map((e) => InkWell(
                                  onTap: () async {
                                    if (widget.classroomModel.studentId == userController.userData().studentId) {
                                      Navigator.pop(context);
                                      showSnackBar(
                                          "You are the creator of this classroom",
                                          context);
                                    } else {
                                      Navigator.pop(context);
                                      showSnackBar("To be Integrated", context);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets
                                        .symmetric(
                                        vertical: 12,
                                        horizontal: 16),
                                    child: Text(e),
                                  ),
                                ))
                                    .toList(),
                              ),
                            ));
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: colorBlack,
                      )),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.classroomModel.className,
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Text(
                    "Class Code",
                    style: TextStyle(
                      color: colorBlack,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    widget.classroomModel.classCode,
                    style: TextStyle(
                      color: colorBlack,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: ()async{
                      await Clipboard.setData(ClipboardData(text: widget.classroomModel.classCode)).then((value) {
                        showSnackBar("Copied", context);
                      });
                    },
                    child:  Icon(
                      Icons.copy,
                      color: colorBlack,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
