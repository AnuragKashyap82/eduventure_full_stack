
import 'package:eduventure_nodejs/Model/class_post_msg_model.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import 'attach_view_screen.dart';

class ClassMsgViewScreen extends StatefulWidget {
  final PostMsgModel postMsgModel;
  const ClassMsgViewScreen({Key? key, required this.postMsgModel}) : super(key: key);

  @override
  State<ClassMsgViewScreen> createState() => _ClassMsgViewScreenState();
}

class _ClassMsgViewScreenState extends State<ClassMsgViewScreen> {

  // var userData = {};
  // var isLoading = false;
  // bool _attachment = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  // getData() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     var userSnap = await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(widget.snap['uid'])
  //         .get();
  //
  //     userData = userSnap.data()!;
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     showSnackBar(e.toString(), context);
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    // if(widget.snap['attachment'] == ""){
    //   setState(() {
    //     _attachment = false;
    //   });
    // }else{
    //   setState(() {
    //     _attachment = true;
    //   });
    // }

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        centerTitle: true,
        backgroundColor: colorPrimary,
        title: Text(
          "Message Details",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: colorBlack),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Icon(Icons.more_vert_sharp, color: colorBlack),
          )
        ],
      ),
      body: SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        "userData[""]"),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "userData['name']",
                    style: TextStyle(
                        fontSize: 16,
                        color: colorBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  widget.postMsgModel.dateTime,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Divider(color: colorBlack, thickness: 0.8,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.postMsgModel.classMsg,
                style: TextStyle(
                    color: colorBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.end,
              ),
            ),

            widget.postMsgModel.isAttachment?
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> AttachmentViewScreen(url: widget.postMsgModel.attachment),));
                },
                child: Icon(Icons.picture_as_pdf, size: 80, color: colorPrimary,)):SizedBox()
          ],
        ),
      ),
    );
  }
}
