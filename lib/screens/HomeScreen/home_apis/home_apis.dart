import 'package:get/get.dart';

import '../../../Controller/books_controller.dart';
import '../../../Controller/classroom_controller.dart';
import '../../../Controller/material_controller.dart';
import '../../../Controller/notice_controller.dart';
import '../../../Controller/result_controller.dart';
import '../../../Controller/user_controller.dart';

class HomeApis extends GetxController{
  Future<void> initController() async{
    Get.put(UserController());
    Get.put(NoticeController());
    Get.put(ClassroomController());
    Get.put(MaterialController());
    Get.put(ResultController());
    Get.put(BooksController());
    // // Get.put(IssueBookController());
  }
}