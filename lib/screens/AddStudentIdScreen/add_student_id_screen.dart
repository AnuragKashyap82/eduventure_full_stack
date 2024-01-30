import 'package:eduventure_nodejs/screens/AddStudentIdScreen/ass_student_apis/add_studentId_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
class AddStudentIdScreen extends StatefulWidget {
  const AddStudentIdScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentIdScreen> createState() => _AddStudentIdScreenState();
}

class _AddStudentIdScreenState extends State<AddStudentIdScreen> {

  AddStudentIdApis addStudentIdApis = Get.put(AddStudentIdApis());

  TextEditingController _studentId = TextEditingController();
  TextEditingController _email = TextEditingController();
  String userType = "Select User Type";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
         
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        title: Text(
          "Add Student Id",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorBlack),
        ),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.all(26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _studentId,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_add_alt_1),
                  hintText: "Unique Id",
                  filled: true,
                  fillColor: gray02,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone_in_talk),
                  hintText: "Email.",
                  fillColor: gray02,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),


                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: colorWhite,
                              surfaceTintColor: colorWhite,
                              alignment: Alignment(0.0, 0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20.0,
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.only(
                                top: 10.0,
                              ),
                              insetPadding:
                                  EdgeInsets.symmetric(horizontal: 21),
                              content: Container(
                                height: 180,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Select User type",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 16,),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          userType = "user";
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Container(
                                          height: 52,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                          ),
                                          child: Center(
                                            child: Text(
                                              "User",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          userType = "teacher";
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Container(
                                          height: 52,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: gray02,
                                              borderRadius: BorderRadius.circular(12)
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Teacher",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(color: gray02),
                          color: gray02),
                      child: Center(
                        child: Text(
                          "${userType}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              SizedBox(
                height: 26,
              ),

                Obx(() {
                  return Container(
                    height: 52,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async{
                          if (_studentId.text.isEmpty) {
                            showSnackBar("Enter Student Id", context);
                          } else if (_email.text.isEmpty) {
                            showSnackBar("Enter Email", context);
                          } else if (userType == "Select User Type") {
                            showSnackBar("Select User Type", context);
                          } else {
                            final message = await addStudentIdApis.addStudentId(_studentId.text.trim(), _email.text.trim(), userType);
                            if(message['status']){
                              showSnackBar("Student Added", context);
                            }else{
                              showSnackBar(message['msg'].toString(), context);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(shape: StadiumBorder(), elevation: 0, backgroundColor: colorPrimary),
                        child: addStudentIdApis.isLoading.value
                            ? CircularProgressIndicator(
                          color: colorWhite,
                          strokeWidth: 2,
                        )
                            : Text("Add Unique Id", style: TextStyle(color: colorWhite),)),
                  );
                })



            ],
          ),
        ),
      ),
    );
  }
}
