import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

import '../../utils/colors.dart';

class YourSubmittedAss extends StatefulWidget {
  final snap;
  const YourSubmittedAss({Key? key, required this.snap}) : super(key: key);

  @override
  State<YourSubmittedAss> createState() => _YourSubmittedAssState();
}

class _YourSubmittedAssState extends State<YourSubmittedAss> {

  bool _isLoading = false;
  late PdfController pdfController;
  int _currentPage = 0;
  int totalPages = 0;
  Future<void> loadController() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final pdfData = await InternetFile.get(widget.snap['submissionUrl']);
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
        title: _isLoading ? CircularProgressIndicator(color: colorWhite,) :
        Text(
          widget.snap['assignmentName'],
            style: TextStyle(fontSize: 16, color: colorBlack, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
    );
  }
}
