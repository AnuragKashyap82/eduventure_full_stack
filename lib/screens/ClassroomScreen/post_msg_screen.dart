import 'package:eduventure_nodejs/Controller/class_post_msg_controller.dart';
import 'package:eduventure_nodejs/Controller/user_controller.dart';
import 'package:eduventure_nodejs/screens/ClassroomScreen/ClassroomApis/classroom_apis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Model/classroom_model.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';

class ClassroomPostMsgScreen extends StatefulWidget {
  final ClassroomModel classroomModel;

  const ClassroomPostMsgScreen({
    Key? key,
    required this.classroomModel,
  }) : super(key: key);

  @override
  State<ClassroomPostMsgScreen> createState() =>
      _ClassroomPostMsgScreenState();
}

class _ClassroomPostMsgScreenState extends State<ClassroomPostMsgScreen> {
  TextEditingController _msg = TextEditingController();
  String url = "";
  ClassroomApis classroomApis = Get.put(ClassroomApis());
  UserController userController = Get.find();
  ClassroomPostMsgController postMsgController = Get.find();

  List<String> deviceTokens = [];
  bool _isLodingToken = false;

  // void getDeviceToken()async{
  //   setState(() {
  //     _isLodingToken = true;
  //   });
  //
  //   List<String> allUsersUid = await FireStoreMethods().getAllUsersJoined(widget.classroomModel.classCode);
  //   List<String> userTokens = await FireStoreMethods().getUsersTokens(allUsersUid);
  //
  //   print("All Joined Tokens: [$userTokens]");
  //
  //   setState(() {
  //     deviceTokens = userTokens;
  //     _isLodingToken = false;
  //   });
  // }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDeviceToken();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        centerTitle: true,
        backgroundColor: colorPrimary,
        title:  Text(
          "Share with you class",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: colorBlack),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
          child: Column(
            children: [
              TextField(
                controller: _msg,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: true,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText:
                  "post your Doubts or class related message",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide.none),
                ),
              ),
              Expanded(child: SizedBox()),
               Divider(
                color: gray02,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async{
                      url = await classroomApis.getPdfAndUpload();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.attach_file, color: colorPrimary),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.video_call_outlined, color: colorPrimary),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.picture_as_pdf, color: colorPrimary),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.more_vert_sharp, color: colorPrimary),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton:
          Obx(() {
            return FloatingActionButton(
                elevation: 0,
                backgroundColor: colorPrimary,
                shape: StadiumBorder(),
                child: classroomApis.isLoading.value
                    ? CircularProgressIndicator(
                  color: colorWhite,
                  strokeWidth: 2,
                )
                    : Icon(
                  Icons.send_outlined,
                  color: colorWhite,
                ),
                onPressed: () async{
                  if(_isLodingToken){
                    showSnackBar("Please wait and send", context);
                  }else{
                    if (url == "") {
                      if (_msg.text == "") {
                        showSnackBar("Enter msg", context);
                      } else {
                        final message = await classroomApis.postClassMsg(widget.classroomModel.classCode, _msg.text.trim(), false, "", userController.userData().studentId);
                        if(message['status']){
                          postMsgController.fetchClassrooms(widget.classroomModel.classCode);
                        }else{
                          showSnackBar("${message['msg']}", context);
                        }
                      }
                    } else {
                      if (_msg.text == "") {
                        showSnackBar("Enter msg", context);
                      } else {
                        final message = await classroomApis.postClassMsg(widget.classroomModel.classCode, _msg.text.trim(), true, url, userController.userData().studentId);
                        if(message['status']){
                          postMsgController.fetchClassrooms(widget.classroomModel.classCode);
                        }else{
                          showSnackBar("${message['msg']}", context);
                        }
                      }
                    }
                  }

                });
          })
    );
  }
}
