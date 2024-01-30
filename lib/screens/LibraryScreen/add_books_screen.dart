import 'package:eduventure_nodejs/screens/LibraryScreen/library_apis/library_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Controller/books_controller.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';

class AddBooksScreen extends StatefulWidget {
  const AddBooksScreen({Key? key}) : super(key: key);

  @override
  State<AddBooksScreen> createState() => _AddBooksScreenState();
}

class _AddBooksScreenState extends State<AddBooksScreen> {
  LibraryApis libraryApis = Get.put(LibraryApis());
  BooksController booksController = Get.find();

  TextEditingController _subName = TextEditingController();
  TextEditingController _bookName = TextEditingController();
  TextEditingController _authorName = TextEditingController();
  TextEditingController _bookId = TextEditingController();
  TextEditingController _bookQty = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _subName.dispose();
    _authorName.dispose();
    _bookName.dispose();
    _bookId.dispose();
    _bookQty.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        title: Text(
          "Add books to library",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colorBlack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 80),
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.all(26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _subName,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.book_outlined,
                    color: colorPrimary,
                  ),
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
                controller: _bookName,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.book_online,
                    color: colorPrimary,
                  ),
                  hintText: "Book Name",
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
              TextField(
                controller: _authorName,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_2_outlined,
                    color: colorPrimary,
                  ),
                  hintText: "Author Name",
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
              TextField(
                controller: _bookId,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_2_outlined,
                    color: colorPrimary,
                  ),
                  hintText: "Book Id/Book No.",
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
              TextField(
                controller: _bookQty,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_2_outlined,
                    color: colorPrimary,
                  ),
                  hintText: "Book Quantity",
                  fillColor: gray02,
                  filled: true,
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
                    onPressed: () async {
                      if (_subName.text.isNotEmpty &&
                          _bookName.text.isNotEmpty &&
                          _authorName.text.isNotEmpty &&
                          _bookId.text.isNotEmpty &&
                          _bookQty.text.isNotEmpty) {
                        final message = await libraryApis.addBook(
                          _authorName.text.trim(),
                          _subName.text.trim(),
                          _bookName.text.trim(),
                          _bookId.text.trim(),
                          _bookQty.text.trim(),
                        );
                        if (message['status']) {
                          showSnackBar("Book Uploaded", context);
                          booksController.fetchBooks();
                        } else {
                          showSnackBar(message['msg'].toString(), context);
                        }
                      } else {
                        showSnackBar("Please fill all the fields!!!", context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        elevation: 0,
                        backgroundColor: colorPrimary),
                    child: libraryApis.isLoading.value
                        ? CircularProgressIndicator(
                            color: colorWhite,
                            strokeWidth: 2,
                          )
                        : Text("Upload Book",
                            style: TextStyle(color: colorWhite)),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
