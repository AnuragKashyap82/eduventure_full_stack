import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

import '../../Controller/notice_controller.dart';
import '../../Controller/user_controller.dart';
import '../../Model/notice_model.dart';
import '../../utils/colors.dart';
import 'notice_apis/notice_apis.dart';

class NoticeViewScreen extends StatefulWidget {
  final NoticeModel noticeModel;

  const NoticeViewScreen({Key? key, required this.noticeModel})
      : super(key: key);

  @override
  State<NoticeViewScreen> createState() => _NoticeViewScreenState();
}

class _NoticeViewScreenState extends State<NoticeViewScreen> {
  final UserController userController = Get.find();
  final NoticeController noticeController = Get.find();
  NoticeApis noticeApis = Get.put(NoticeApis());
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
      final pdfData = await InternetFile.get(widget.noticeModel.noticeUrl);
      pdfController = PdfController(
        document: PdfDocument.openData(pdfData),
      );
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
            "${widget.noticeModel.noticeTitle}\n${widget.noticeModel.noticeNo}",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: colorBlack),
          ),
          centerTitle: true,
          actions: [
            // Text(
            //   "Page ${_currentPage + 1} of $totalPages",
            //   style: TextStyle(
            //       fontSize: 12, fontWeight: FontWeight.bold, color: colorBlack),
            // ),
          ],
        ),
        body: Center(
          child: _isLoading
              ? CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorPrimary,
                )
              : PdfView(
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
                final message = await noticeApis.deleteNotice(widget.noticeModel.noticeId);
                print(message.toString());
                await noticeController.fetchNotices();
                Navigator.pop(context);
              },
              child: noticeApis.isLoading.value
                  ? CircularProgressIndicator(
                      color: colorBlack,
                      strokeWidth: 2,
                    )
                  : Icon(
                      Icons.delete,
                      color: colorWhite,
                    ));
        }));
  }
}
