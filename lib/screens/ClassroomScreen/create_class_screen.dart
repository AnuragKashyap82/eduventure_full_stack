import 'package:eduventure_nodejs/screens/ClassroomScreen/ClassroomApis/classroom_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/classroom_controller.dart';
import '../../Controller/user_controller.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';

class CreateClassScreen extends StatefulWidget {
  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  ClassroomController classroomController = Get.find();
  final UserController userController = Get.find();

  ClassroomApis classroomApis = Get.put(ClassroomApis());

  TextEditingController _subName = TextEditingController();
  TextEditingController _className = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subName.dispose();
    _className.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        title: Text(
          "Create Class",
          style: TextStyle(fontSize: 16, color: colorBlack, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(26),
        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: [
            TextField(
              controller: _subName,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autofocus: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.book_outlined, color: colorPrimary,),
                hintText: "SubjectName",
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
              controller: _className,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autofocus: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.book_online, color: colorPrimary,),
                hintText: "ClassName/branch/sem",
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
            SizedBox(
              height: 40,
            ),
            Obx(() {
              return Container(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async{
                    if (_subName.text.isEmpty || _className.text.isEmpty) {
                      showSnackBar("Please Fill all the fields!!!", context);
                    } else  {
                      final message = await classroomApis.createClass(_className.text.trim(), _subName.text.trim());
                      if(message['status']){
                        final messagejoin = await classroomApis.joinClass(message['classroomModel']['classCode']);
                        if(messagejoin['status']){
                          showSnackBar("Classroom Created", context);
                          classroomController.fetchClassrooms();
                        }else{
                          showSnackBar(messagejoin['msg'].toString(), context);
                        }
                      }else{
                        showSnackBar(message['msg'].toString(), context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(shape: StadiumBorder(), backgroundColor: colorPrimary, elevation: 0),
                  child: classroomApis.isLoading.value
                      ? CircularProgressIndicator(
                    color: colorWhite,
                    strokeWidth: 2,
                  )
                      : Text("Create Class".toUpperCase(), style: TextStyle(color: colorWhite),),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
