import 'package:eduventure_nodejs/screens/ClassroomScreen/ClassroomApis/classroom_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Controller/classroom_controller.dart';
import '../../Controller/user_controller.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';

class JoinClassScreen extends StatefulWidget {
  const JoinClassScreen({Key? key}) : super(key: key);

  @override
  State<JoinClassScreen> createState() => _JoinClassScreenState();
}

class _JoinClassScreenState extends State<JoinClassScreen> {
  ClassroomController classroomController = Get.find();
  TextEditingController _classCode = TextEditingController();

  final UserController userController = Get.find();
  ClassroomApis classroomApis = Get.put(ClassroomApis());


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _classCode.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
         
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        title: Text("Create Class",style: TextStyle(fontSize: 16, color: colorBlack, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        padding: EdgeInsets.all(26),
        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: [
            TextField(
              controller: _classCode,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autofocus: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.book_outlined, color: colorPrimary,),
                suffixIcon: Icon(Icons.remove_red_eye, color: colorPrimary,),
                hintText: "Classroom Code",
                filled: true,
                fillColor: gray02,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Obx(() {
              return Container(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async{
                      final message = await classroomApis.joinClass(_classCode.text.trim());
                      if(message['status']){
                        final messagejoin = await classroomApis.joinClassStudent(_classCode.text.trim());
                        if(messagejoin['status']){
                          showSnackBar("Classroom Joined", context);
                          classroomController.fetchClassrooms();
                        }else{
                          showSnackBar(messagejoin['msg'].toString(), context);
                        }
                      }else{
                        showSnackBar(message['msg'].toString(), context);
                      }
                    },
                    style: ElevatedButton.styleFrom(shape: StadiumBorder(), elevation: 0, backgroundColor: colorPrimary),
                    child: classroomApis.isLoading.value ? CircularProgressIndicator(color: colorWhite, strokeWidth: 2,) :
                    Text("Join Class", style: TextStyle(color: colorWhite),)
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
