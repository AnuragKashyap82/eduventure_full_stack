import 'package:eduventure_nodejs/Controller/issue_book_controller.dart';
import 'package:eduventure_nodejs/screens/LibraryScreen/library_apis/library_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../Model/issue_book_model.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import 'Widgets/applied_card.dart';

class UserAllAppliedBooksScreen extends StatefulWidget {
  final IssueBookModel issueBookModel;

  const UserAllAppliedBooksScreen({Key? key, required this.issueBookModel})
      : super(key: key);

  @override
  State<UserAllAppliedBooksScreen> createState() =>
      _UserAllAppliedBooksScreenState();
}

class _UserAllAppliedBooksScreenState extends State<UserAllAppliedBooksScreen> {
  final IssueBookController issueBookController = Get.find();
  LibraryApis libraryApis = Get.put(LibraryApis());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Call your function here
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      issueBookController
          .fetchIndividualIssueBooks(widget.issueBookModel.studentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: colorBlack),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Text(
                widget.issueBookModel.name,
                style: TextStyle(
                    fontSize: 14,
                    color: colorBlack,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              widget.issueBookModel.studentId,
              style: TextStyle(
                  fontSize: 14, color: colorBlack, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          widget.issueBookModel.photoUrl != ""
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        NetworkImage(widget.issueBookModel.photoUrl),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: colorWhite, shape: BoxShape.circle),
                    child: Center(
                        child: Icon(
                      Icons.person,
                      color: colorPrimary,
                      size: 26,
                    )),
                  ),
                ),
        ],
      ),
      body: Obx(() {
        if (issueBookController.isLoading.value) {
          return Center(
            child:
                CircularProgressIndicator(strokeWidth: 2, color: colorPrimary),
          );
        }
        if (issueBookController.userAppliedBooks.isEmpty) {
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
          itemCount: issueBookController.userAppliedBooks.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, mainAxisExtent: 128),
          itemBuilder: (BuildContext context, int index) {
            final appliedBooks = issueBookController.userAppliedBooks[index];
            return GestureDetector(
              onTap: ()async{
                showModalBottomSheet(
                  isScrollControlled: true,
                  showDragHandle: true,
                  enableDrag: true,
                  barrierColor: Colors.transparent,
                  backgroundColor: colorWhite,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(16.0).copyWith(top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Confirm Issue",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: colorPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                         Align(
                           alignment: Alignment.center,
                           child: Text(
                            "Book Name: ${appliedBooks.bookName}",
                            style: TextStyle(
                              color: colorBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                        ),
                         ),
                        const SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Book Id: ${appliedBooks.bookId}",
                            style: TextStyle(
                              color: colorBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () async{
                            final message = await libraryApis.updateToIssued(appliedBooks.issueId);
                            if(message['status']){
                              Navigator.pop(context);
                              await issueBookController.fetchIndividualIssueBooks(widget.issueBookModel.studentId);
                            }else{
                              showSnackBar(message['msg'].toString(), context);
                            }

                          },
                          child: Container(
                            height: 52,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: gray02,
                              borderRadius:
                              BorderRadius.circular(26),
                            ),
                            child: Center(
                              child: libraryApis.isLoading.value?CircularProgressIndicator(color: colorPrimary, strokeWidth: 2,):Text(
                                "Confirm Issued",
                                style: TextStyle(color: colorBlack),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: AppliedCard(issueBookModel: appliedBooks),
            );
          },
        );
      }),
    );
  }
}
