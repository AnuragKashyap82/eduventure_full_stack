import 'package:eduventure_nodejs/Model/books_model.dart';
import 'package:flutter/material.dart';

import '../../../Model/issue_book_model.dart';
import '../../../utils/colors.dart';

class AppliedCard extends StatefulWidget {
  final IssueBookModel issueBookModel;
  const AppliedCard({Key? key, required this.issueBookModel}) : super(key: key);

  @override
  State<AppliedCard> createState() => _AppliedCardState();
}

class _AppliedCardState extends State<AppliedCard> {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: gray02,
              borderRadius: BorderRadius.circular(12)),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child:  Text(
                  widget.issueBookModel.subjectName,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  widget.issueBookModel.bookName,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child:  Text(
                          "Book Id: ${widget.issueBookModel.bookId}",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 4),
                    child: Text(
                      widget.issueBookModel.authorName,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 4),
                    child: Text(
                      "Applied Date: ${widget.issueBookModel.appliedDate}",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              )
            ],
          ),
      ),
    );
  }
}
