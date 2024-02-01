import 'package:eduventure_nodejs/Model/class_ass_model.dart';
import 'package:eduventure_nodejs/Model/class_post_msg_model.dart';
import 'package:eduventure_nodejs/Repository/assignment_repository.dart';
import 'package:get/get.dart';
import '../apis/apis.dart';

class AssignmentController extends GetxController {
  static AssignmentController get instance => Get.find();

  final isLoading = false.obs;
  final _assignmentRepository = Get.put(AssignmentRepository()); // Adjust repository reference
  RxList<AssignmentModel> allAssignment = <AssignmentModel>[].obs;

  Future<void> fetchAssignment(String classCode) async {
    try {
      isLoading.value = true;

      String token = await Apis().getToken();
      if (token != '') {
        final assignment = await _assignmentRepository.getAllAssignment(classCode);

        allAssignment.assignAll(assignment);
        isLoading.value = false;
      }else{

      }

    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
