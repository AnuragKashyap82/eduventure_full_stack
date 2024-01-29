import 'package:eduventure_nodejs/screens/ResultScreen/result_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/result_controller.dart';
import '../../utils/colors.dart';
import 'Widgets/result_card.dart';

class AllResultScreen extends StatefulWidget {
  final String semester;
  final String branch;

  const AllResultScreen(
      {Key? key, required this.semester, required this.branch})
      : super(key: key);

  @override
  State<AllResultScreen> createState() => _AllResultScreenState();
}

class _AllResultScreenState extends State<AllResultScreen> {

  ResultController resultController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resultController.fetchResults(widget.branch, widget.semester,);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
         
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        title: Text("${widget.semester} - ${widget.branch}",style: TextStyle(fontSize: 16, color: colorBlack, fontWeight: FontWeight.bold),),
      ),
      body: Obx(() {
        if (resultController.isLoading.value)
          return  Center(
            child:
            CircularProgressIndicator(strokeWidth: 2, color: colorPrimary),
          );
        if (resultController.allResults.isEmpty) {
          return Center(
            child: Text(
              "No Result",
              style: TextStyle(
                fontSize: 14,
                color: colorBlack,
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: resultController.allResults.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            final result = resultController.allResults[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ResultViewScreen(
                  resultModel: result,
                )));
              },
              child: Container(
                child: ResultCard(
                  resultModel: result,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
