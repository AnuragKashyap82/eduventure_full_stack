import 'package:eduventure_nodejs/Controller/books_controller.dart';
import 'package:eduventure_nodejs/Controller/issue_book_controller.dart';
import 'package:eduventure_nodejs/screens/LibraryScreen/library_apis/library_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../Controller/user_controller.dart';
import '../../Model/books_model.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';

class BookViewScreen extends StatefulWidget {
  final BooksModel booksModel;

  const BookViewScreen({Key? key, required this.booksModel}) : super(key: key);

  @override
  State<BookViewScreen> createState() => _BookViewScreenState();
}

class _BookViewScreenState extends State<BookViewScreen> {
  bool _isAvailable = true;
  bool _isButtonDisabled = false;
  bool _alreadyIssued = false;

  final UserController userController = Get.find();
  LibraryApis libraryApis = Get.put(LibraryApis());
  final BooksController booksController = Get.find();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAvailable();
  }

  void checkAvailable() {
    if (widget.booksModel.bookQty == "" || widget.booksModel.bookQty == "0") {
      setState(() {
        _isAvailable = false;
        _isButtonDisabled = true;
      });
    } else {
      setState(() {
        _isAvailable = true;
        _isButtonDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        systemOverlayStyle:  SystemUiOverlayStyle(
          statusBarColor: colorPrimary,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        title: Text(widget.booksModel.subjectName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorBlack)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BookWidget(heading: "Subject Name:", name: "${widget.booksModel.subjectName}", enabled: true, iconData: Icons.menu_book_rounded),
          BookWidget(heading: "Book Name:", name: "${widget.booksModel.bookName}", enabled: true, iconData: Icons.menu_book_rounded),
          BookWidget(heading: "Author Name:", name: "${widget.booksModel.authorName}", enabled: true, iconData: Icons.person),
          BookWidget(heading: "Book Id:", name: "${widget.booksModel.bookId}", enabled: true, iconData: Icons.pin_outlined),
          BookWidget(heading: "Quantity Available:", name: "${widget.booksModel.bookQty}", enabled: true, iconData: Icons.pin_outlined),
          SizedBox(
            height: 30,
          ),
          Obx(() {
            return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () async{
                    if (_isButtonDisabled) {
                      showSnackBar("Book Not Available", context);
                    } else if(_alreadyIssued){
                      showSnackBar("Already Issued!!", context);
                    }else{
                      final message = await libraryApis.applyIssue(widget.booksModel.bookId);
                      if(message['status']){
                        final messagede = await libraryApis.decreaseQtyCount(widget.booksModel.bookId);
                        if(messagede['status']){
                          showSnackBar("Applied for Issue", context);
                          await booksController.fetchMyBooks();
                        }else{
                          showSnackBar(messagede['msg'].toString(), context);
                        }

                      }else{
                        showSnackBar(message['msg'].toString(), context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(shape: StadiumBorder(), backgroundColor: colorPrimary, elevation: 0),
                  child: libraryApis.isLoading.value
                      ? CircularProgressIndicator(
                    color: colorWhite, strokeWidth: 2,
                  )
                      : Text(_alreadyIssued?"Already Issued":"Issue", style: TextStyle(color: colorWhite),),
                ),
              ),
            );
          })

        ],
      ),
    );
  }
}


class BookWidget extends StatelessWidget {
  final String heading;
  final String name;
  final bool enabled;
  final IconData iconData;

  const BookWidget(
      {Key? key, required this.heading, required this.name, required this.enabled, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(heading, style: TextStyle(color: colorBlack, fontWeight: FontWeight.w500),),
      trailing: enabled?SizedBox():Icon(Icons.verified_user_outlined, color: colorPrimary,size: 24,),
      subtitle: Text(name),
      leading: Icon(iconData, color: colorPrimary,),
    );
  }
}