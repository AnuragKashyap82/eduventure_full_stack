import 'package:eduventure_nodejs/screens/LibraryScreen/Widgets/issued_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/books_controller.dart';
import '../../../utils/colors.dart';

class IssuedBookScreen extends StatefulWidget {
  const IssuedBookScreen({Key? key}) : super(key: key);

  @override
  State<IssuedBookScreen> createState() => _IssuedBookScreenState();
}

class _IssuedBookScreenState extends State<IssuedBookScreen> {
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
        if (booksController.myIssuedBooks.isEmpty) {
          return Center(
            child: Text(
              "No Issued Books",
              style: TextStyle(
                fontSize: 14,
                color: colorBlack,
              ),
            ),
          );
        }
        return GridView.builder(
          itemCount: booksController.myIssuedBooks.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, mainAxisExtent: 128),
          itemBuilder: (BuildContext context, int index) {
            final appliedBooks = booksController.myIssuedBooks[index];
            return Container(child: IssuedCard(issueBookModel: appliedBooks,));
          },
        );
      }),
    );
  }
}
