import 'package:eduventure_nodejs/Controller/user_controller.dart';
import 'package:eduventure_nodejs/Model/class_post_msg_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';

class ClassPostMsgCard extends StatefulWidget {
  final PostMsgModel postMsgModel;

  const ClassPostMsgCard({Key? key, required this.postMsgModel}) : super(key: key);

  @override
  State<ClassPostMsgCard> createState() => _ClassPostMsgCardState();
}

class _ClassPostMsgCardState extends State<ClassPostMsgCard> {

  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(4),
      child:Container(
        height: 80,
        width: 600,
        decoration: BoxDecoration(
          border: Border.all(color: colorWhite),
          borderRadius: BorderRadius.circular(26),
          color: colorWhite,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage("userData[]"),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Fetch user data from widget.postMsgModel.studentId
                        Text("To be integrated!!!",
                          style: TextStyle(
                              fontSize: 16,
                              color: colorBlack,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.postMsgModel.classMsg,
                          style: TextStyle(
                            color: colorBlack,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16),
                            shrinkWrap: true,
                            children: [
                              'Delete',
                            ]
                                .map((e) => InkWell(
                              onTap: () async {
                                if (widget.postMsgModel.studentId == userController.userData().studentId) {
                                  // FirebaseFirestore.instance
                                  //     .collection("classroom")
                                  //     .doc(widget.snap['classCode'])
                                  //     .collection("postMsg")
                                  //     .doc(widget.snap['timestamp'])
                                  //     .delete()
                                  //     .then((value) => {
                                  //   Navigator.pop(context)
                                  // });
                                } else {
                                  Navigator.pop(context);
                                  print("Tu khud teacher hai lowde ....q dellete kar rha bsdk");
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: Text(e),
                              ),
                            ))
                                .toList(),
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.more_vert),
                    color: colorBlack,
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.postMsgModel.isAttachment
                        ? Container(
                      height: 26,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Center(
                        child:  Text(
                          "Attachment",
                          style: TextStyle(
                              color: colorWhite,
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    )
                        : SizedBox(),
                    Text(
                      widget.postMsgModel.dateTime,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
