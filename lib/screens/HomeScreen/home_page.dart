import 'package:eduventure_nodejs/Controller/user_controller.dart';
import 'package:eduventure_nodejs/apis/apis.dart';
import 'package:eduventure_nodejs/screens/HomeScreen/home_apis/home_apis.dart';
import 'package:eduventure_nodejs/screens/HomeScreen/widgets/dashboard_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../utils/colors.dart';
import '../AddStudentIdScreen/add_student_id_screen.dart';
import '../ClassroomScreen/classroom_screen.dart';
import '../LibraryScreen/library_screen.dart';
import '../MaterialScreen/material_screen.dart';
import '../NoticeScreen/notice_screen.dart';
import '../ProfileScreen/profile_screen.dart';
import '../ResultScreen/result_screen.dart';
import '../SpeechToTextScreen/speech_to_text.dart';
import '../TimeTableScreens/time_table_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeApis().initController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorWhite,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            iconTheme: IconThemeData(color: colorBlack),
            elevation: 0,
            backgroundColor: colorPrimary,
          ),
        ),
        body: Obx(() {
          if (userController.isLoading.value)
            return Center(
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: colorPrimary),
            );
          Future.delayed(Duration.zero, () {});
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const ProfileScreen()));
                                    },
                                    child: Text(
                                      "Hello, ${userController.userData().name}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: colorBlack),
                                    ),
                                  ),
                                  const Text(
                                    "Have a great day",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const ProfileScreen()));
                                },
                                child: Container(
                                  height: 46,
                                  width: 46,
                                  decoration: BoxDecoration(
                                      color: colorPrimary,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child:
                                        userController.userData().photoUrl != ""
                                            ? CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(
                                                    userController
                                                        .userData()
                                                        .photoUrl),
                                              )
                                            : Icon(
                                                Icons.person_pin,
                                                color: colorWhite,
                                                size: 20,
                                              ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 18, top: 8, bottom: 4),
                  child: Text(
                    "Dashboard Section",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorBlack,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      DashboardItem(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoticeScreen()));
                          },
                          title: "Notice",
                          subTitle: "All official notice are here",
                          trailing: "See all notice",
                          iconData: Icons.school_rounded),
                      const SizedBox(
                        width: 8,
                      ),
                      DashboardItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClassroomScreen()));
                        },
                        title: "Classroom",
                        subTitle: "You can create or join class",
                        trailing: "See all classes",
                        iconData: Icons.class_outlined,
                      ),

                      const SizedBox(
                        width: 8,
                      ),
                      DashboardItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LibraryScreen(

                                  )));
                        },
                        title: "Library",
                        subTitle: "Here all books are available for issue or reading",
                        trailing: "See all books",
                        iconData: Icons.library_add,
                      ),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 18, top: 18, bottom: 4),
                  child: Text(
                    "Admin Section",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      userController.userData().userType == "admin"
                          ?
                  DashboardItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const AddStudentIdScreen()));
                    },
                    title: "Add Student Id",
                    subTitle: "Add student id of newly admitted students",
                    trailing: "Add student Id",
                    iconData: Icons.add_circle_outlined,
                  )

                    : const SizedBox(),
                      userController.userData().userType == "admin"
                          ? const SizedBox(
                              width: 8,
                            )
                          : const SizedBox(
                              width: 0,
                            ),
                      DashboardItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const TimeTableScreen()));
                        },
                        title: "Update Time Table",
                        subTitle: "Add Time Table for the All Branch and year",
                        trailing: "Add time table",
                        iconData: Icons.add_circle_outlined,
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 18, top: 18, bottom: 4),
                  child: Text(
                    "Result Section",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorBlack,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      DashboardItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen()));
                        },
                        title: "Result",
                        subTitle: "Here you can see all your results",
                        trailing: "See all Results",
                        iconData: Icons.school_outlined,
                      ),

                      const SizedBox(
                        width: 8,
                      ),
                      DashboardItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MaterialsScreen(
                                    userType: userController
                                        .userData()
                                        .userType,
                                  )));
                        },
                        title: "Materials",
                        subTitle: "All materials are available here",
                        trailing: "See all Materials",
                        iconData: Icons.my_library_books_outlined,
                      ),

                      const SizedBox(
                        width: 8,
                      ),
                      DashboardItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SpeechToTextScreen()));
                        },
                        title: "Speech to Text",
                        subTitle: "Here you can translate your speech to text",
                        trailing: "Explore this STT",
                        iconData: Icons.mic_none_outlined,
                      ),

                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        }));
  }
}
