import 'package:eduventure_nodejs/Controller/books_controller.dart';
import 'package:eduventure_nodejs/screens/LibraryScreen/Widgets/returned_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';



class ReturnedBookScreen extends StatefulWidget {
  const ReturnedBookScreen({Key? key}) : super(key: key);

  @override
  State<ReturnedBookScreen> createState() => _ReturnedBookScreenState();
}

class _ReturnedBookScreenState extends State<ReturnedBookScreen> {

  BooksController booksController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (booksController.isLoading.value)
          return Center(
            child:
            CircularProgressIndicator(strokeWidth: 2, color: colorPrimary),
          );
        if (booksController.myReturnedBooks.isEmpty) {
          return Center(
            child: Text(
              "No Returned Books",
              style: TextStyle(
                fontSize: 14,
                color: colorBlack,
              ),
            ),
          );
        }
        return GridView.builder(
          itemCount: booksController.myReturnedBooks.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, mainAxisExtent: 128),
          itemBuilder: (BuildContext context, int index) {
            final appliedBooks = booksController.myReturnedBooks[index];
            return Container(child: ReturnedCard(issueBookModel: appliedBooks,));
          },
        );
      })
    );
  }
}
