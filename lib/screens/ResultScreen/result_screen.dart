import 'package:eduventure_nodejs/Controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import 'add_result_screen.dart';
import 'all_result_screen.dart';

class ResultScreen extends StatefulWidget {
   ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

String semester = "Select Your Semester";
String branch = "Select Your branch";
bool _isLoading = false;

class _ResultScreenState extends State<ResultScreen> {

  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
         
        elevation: 0,
        iconTheme:  IconThemeData(color: colorBlack),
        title:  Text("Result",style: TextStyle(fontSize: 16, color: colorBlack, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              :  const EdgeInsets.all(26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: colorWhite,
                          surfaceTintColor: colorWhite,
                          alignment: const Alignment(0.0, 0.0),
                          shape:  const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                20.0,
                              ),
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(
                            top: 4.0, bottom: 4
                          ),
                          insetPadding:
                          const EdgeInsets.symmetric(horizontal: 0),
                          content: Container(
                            constraints: BoxConstraints(maxHeight: 350),
                            width: 320,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 12,
                                  ),
                                   const Text(
                                    "Select Your Semester",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "1st Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child:  Padding(
                                      padding:  const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child:  const Center(
                                          child: Text(
                                            "1st Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "2nd Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:  const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child:  const Center(
                                          child: Text(
                                            "2nd Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "3rd Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:  const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child:  const Center(
                                          child: Text(
                                            "3rd Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "4th Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:  const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child:  const Center(
                                          child: Text(
                                            "4th Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "5th Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child:Padding(
                                      padding:  const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child:  const Center(
                                          child: Text(
                                            "5th Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "6th Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:  const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child:  const Center(
                                          child: Text(
                                            "6th Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "7th Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:  const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child:  const Center(
                                          child: Text(
                                            "7th Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        semester = "8th Semester";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:  const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                      child: Container(
                                        height: 52,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: gray02,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child:  const Center(
                                          child: Text(
                                            "8th Semester",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: gray02),
                      color: gray02),
                  child: Center(
                    child: Text(
                      "${semester}",
                      style:  const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
               const SizedBox(
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
                          alignment: const Alignment(0.0, 0.0),
                          shape:  const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                20.0,
                              ),
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(
                              top: 4.0, bottom: 4
                          ),
                          insetPadding:
                          const EdgeInsets.symmetric(horizontal: 0),
                          content: Container(
                              width: 320,
                              child: SingleChildScrollView(
                                  padding:  const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        "Select Your branch",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            branch = "CSE";
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding:  const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                          child: Container(
                                            height: 52,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: gray02,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child:  const Center(
                                              child: Text(
                                                "CSE",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            branch = "ME";
                                          });
                                          Navigator.pop(context);
                                        },
                                        child:Padding(
                                          padding:  const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                          child: Container(
                                            height: 52,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: gray02,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child:  const Center(
                                              child: Text(
                                                "ME",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            branch = "ECE";
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding:  const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                          child: Container(
                                            height: 52,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: gray02,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child:  const Center(
                                              child: Text(
                                                "ECE",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            branch = "EE";
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding:  const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                          child: Container(
                                            height: 52,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: gray02,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child:  const Center(
                                              child: Text(
                                                "EE",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            branch = "CE";
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding:  const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 4),
                                          child: Container(
                                            height: 52,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: gray02,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child:  const Center(
                                              child: Text(
                                                "CE",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                       const SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ))),
                        );
                      });
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: gray02),
                      color: gray02),
                  child: Center(
                    child: Text(
                      "${branch}",
                      style:  const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
               const SizedBox(
                height: 16,
              ),
              Container(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (semester == "Select Your Semester") {
                        showSnackBar("Select Your Semester", context);
                      } else if (branch == "Select Your branch") {
                        showSnackBar("Select Your branch", context);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllResultScreen(
                                  branch: branch,
                                  semester: semester,
                                )));
                      }
                    },
                    style: ElevatedButton.styleFrom(shape:  const StadiumBorder(), elevation: 0, backgroundColor: colorPrimary),
                    child: _isLoading
                        ?  CircularProgressIndicator(
                      color: colorWhite,
                      strokeWidth: 2,
                    )
                        :  Text("Check Result", style: TextStyle(color: colorWhite),)),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: userController.userData().userType == "teacher"? FloatingActionButton(
        backgroundColor: colorPrimary,
        shape: const StadiumBorder(),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  const AddResultScreen()));
        },
        child:  Icon(Icons.add, color: colorBlack,),
      ):userController.userData().userType == "admin"?FloatingActionButton(
        backgroundColor: colorPrimary,
        shape: const StadiumBorder(),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  const AddResultScreen()));
        },
        child:  Icon(Icons.add, color: colorBlack,),
      ): const SizedBox(),

    );
  }
}
