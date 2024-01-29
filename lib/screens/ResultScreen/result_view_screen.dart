import 'package:eduventure_nodejs/Controller/result_controller.dart';
import 'package:eduventure_nodejs/screens/ResultScreen/result_apis/result_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

import '../../Controller/user_controller.dart';
import '../../Model/result_model.dart';
import '../../utils/colors.dart';

class ResultViewScreen extends StatefulWidget {
  final ResultModel resultModel;
  const ResultViewScreen({Key? key, required this.resultModel}) : super(key: key);

  @override
  State<ResultViewScreen> createState() => _ResultViewScreenState();
}

class _ResultViewScreenState extends State<ResultViewScreen> {
  final UserController userController = Get.find();
  final ResultController resultController = Get.find();
  final ResultApis resultApis = Get.put(ResultApis());
  bool _isLoading = false;
  late PdfController pdfController;
  late PageController pageController;
  int _currentPage = 0;
  int totalPages = 0;

  Future<void> loadController() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final pdfData = await InternetFile.get(widget.resultModel.resultUrl);
      pdfController = PdfController(document: PdfDocument.openData(pdfData),);
      totalPages = (await pdfController.pagesCount)!;
      print("Anuragd $totalPages");
    } catch (e) {
      // Handle error loading PDF, you can show an error message or take appropriate action
      print('Error loading PDF: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadController();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
         
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        title: Text(
          "${widget.resultModel.semester} - ${widget.resultModel.branch}",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: colorBlack),
        ),
        centerTitle: true,
      ),
      body: Center(
        child:  _isLoading
            ? CircularProgressIndicator(
          strokeWidth: 2,
          color: colorPrimary,
        )
            :PdfView(
          controller: pdfController,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              _currentPage = page;
            });
          },
        ),
      ),
        floatingActionButton: Obx(() {
          return FloatingActionButton(
              backgroundColor: colorPrimary,
              foregroundColor: colorPrimary,
              elevation: 0,
              shape: StadiumBorder(),
              onPressed: () async {
                final message = await resultApis.deleteResult(widget.resultModel.resultId);
                print(message.toString());
                Navigator.pop(context);
              },
              child: resultApis.isLoading.value
                  ? CircularProgressIndicator(
                color: colorBlack,
                strokeWidth: 2,
              )
                  : Icon(
                Icons.delete,
                color: colorWhite,
              ));
        })
    );
  }
}
