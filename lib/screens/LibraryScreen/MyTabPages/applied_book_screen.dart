import 'package:eduventure_nodejs/Controller/books_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../Widgets/applied_card.dart';

class AppliedBookScreen extends StatefulWidget {
  const AppliedBookScreen({Key? key}) : super(key: key);

  @override
  State<AppliedBookScreen> createState() => _AppliedBookScreenState();
}

class _AppliedBookScreenState extends State<AppliedBookScreen> {
  BooksController booksController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Obx(() {
        if (booksController.isLoading.value)
          return Center(
            child:
                CircularProgressIndicator(strokeWidth: 2, color: colorPrimary),
          );
        if (booksController.myAppliedBooks.isEmpty) {
          return Center(
            child: Text(
              "No Applied Books",
              style: TextStyle(
                fontSize: 14,
                color: colorBlack,
              ),
            ),
          );
        }
        return GridView.builder(
          itemCount: booksController.myAppliedBooks.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, mainAxisExtent: 128),
          itemBuilder: (BuildContext context, int index) {
            final appliedBooks = booksController.myAppliedBooks[index];
            return Container(child: AppliedCard(issueBookModel: appliedBooks,));
          },
        );
      }),
    );
  }
}
