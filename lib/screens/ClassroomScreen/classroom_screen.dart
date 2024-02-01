import 'package:eduventure_nodejs/Controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import '../../Controller/classroom_controller.dart';
import '../../utils/colors.dart';
import 'join_class_screen.dart';
import 'Widgets/classroom_card.dart';
import 'classroom_view_screen.dart';
import 'create_class_screen.dart';

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({Key? key}) : super(key: key);

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  ClassroomController classroomController = Get.find();
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    int _count = 2;

    setState(() {
      if (size < 400) {
        _count = 1;
      } else if (size > 400 && size < 500) {
        _count = 1;
      } else if (size > 500 && size < 600) {
        _count = 1;
      } else if (size > 600 && size < 800) {
        _count = 2;
      } else if (size > 800 && size < 1000) {
        _count = 3;
      } else if (size > 1000 && size < 1200) {
        _count = 3;
      } else if (size > 1200 && size < 1400) {
        _count = 4;
      } else if (size > 1400 && size < 1600) {
        _count = 4;
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        title: Text(
          "Classroom",
          style: TextStyle(
              fontSize: 16, color: colorBlack, fontWeight: FontWeight.bold),
        ),
      ),
      body:
      Obx(() {
        if (classroomController.isLoading.value)
          return Center(
            child:
                CircularProgressIndicator(strokeWidth: 2, color: colorPrimary),
          );
        if (classroomController.allClassrooms.isEmpty) {
          return Center(
            child: Text(
              "No Classess",
              style: TextStyle(
                fontSize: 14,
                color: colorBlack,
              ),
            ),
          );
        }
        return GridView.builder(
          itemCount: classroomController.allClassrooms.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _count, mainAxisExtent: 175),
          itemBuilder: (BuildContext context, int index) {
            final classroom = classroomController.allClassrooms[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>
                    ClassroomViewScreen(
                      classroomModel: classroom,
                    )));
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ClassroomCard(
                    classroomModel: classroom,
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: SpeedDial(
        direction: SpeedDialDirection.up,
        icon: Icons.add,
        //icon on Floating action button
        activeIcon: Icons.close,
        //icon when menu is expanded on button
        backgroundColor: colorPrimary,
        //background color of button
        foregroundColor: colorBlack,
        //font color, icon color in button
        activeBackgroundColor: colorPrimary,
        //background color when menu is expanded
        activeForegroundColor: colorBlack,
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: colorBlack,
        overlayOpacity: 0,
        elevation: 0,
        //shadow elevation of button
        shape: CircleBorder(),
        //shape of button

        children: [
          userController.userData().userType == "teacher"
              ? SpeedDialChild(
                  //speed dial child
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.add,
                    color: colorBlack,
                  ),
                  backgroundColor: colorPrimary,
                  foregroundColor: colorWhite,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateClassScreen()));
                  },
                )
              : userController.userData().userType == "admin"
                  ? SpeedDialChild(
                      //speed dial child
                      child: Icon(
                        Icons.add,
                        color: colorBlack,
                      ),
                      shape: CircleBorder(),
                      backgroundColor: colorPrimary,
                      foregroundColor: colorWhite,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateClassScreen()));
                      },
                    )
                  : SpeedDialChild(),

          SpeedDialChild(
            shape: CircleBorder(),
            child: Icon(
              Icons.class_outlined,
              color: colorBlack,
            ),
            backgroundColor: colorPrimary,
            foregroundColor: colorWhite,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => JoinClassScreen()));
            },
          ),

          //add more menu item children here
        ],
      ),
    );
  }
}
