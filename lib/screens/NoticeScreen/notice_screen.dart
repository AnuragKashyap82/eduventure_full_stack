import 'package:eduventure_nodejs/screens/NoticeScreen/add_notice_screen.dart';
import 'package:eduventure_nodejs/screens/NoticeScreen/widgets/notice_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Controller/notice_controller.dart';
import '../../Controller/user_controller.dart';
import '../../utils/colors.dart';
import 'notice_view_screen.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  final NoticeController noticeController = Get.find();
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        title: Text(
          "Notice Section",
          style: TextStyle(
              fontSize: 16, color: colorBlack, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (userController.userData().userType == "teacher")
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => AddNoticeScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.edit_note_sharp, color: colorBlack),
              ),
            )
          else if (userController.userData().userType == "admin")
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => AddNoticeScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.edit_note_sharp, color: colorBlack),
              ),
            )
          else
            SizedBox(), // User is neither teacher nor admin
        ],
      ),
      body:
      Obx(() {
        if (noticeController.isLoading.value)
          return Center(
            child:
                CircularProgressIndicator(strokeWidth: 2, color: colorPrimary),
          );
        if (noticeController.allNotices.isEmpty) {
          return Center(
            child: Text(
              "No Notices",
              style: TextStyle(
                fontSize: 14,
                color: colorBlack,
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: noticeController.allNotices.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            final notice = noticeController.allNotices[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoticeViewScreen(
                              noticeModel: notice,
                            )));
              },
              child: Container(
                child: NoticeCard(
                  noticeModel: notice,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
