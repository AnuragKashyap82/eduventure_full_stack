import 'package:eduventure_nodejs/Model/class_ass_model.dart';
import 'package:eduventure_nodejs/Model/class_post_msg_model.dart';
import 'package:eduventure_nodejs/Model/submission_model.dart';
import 'package:eduventure_nodejs/Repository/assignment_repository.dart';
import 'package:eduventure_nodejs/Repository/submission_repository.dart';
import 'package:get/get.dart';
import '../apis/apis.dart';

class SubmissionController extends GetxController {
  static SubmissionController get instance => Get.find();

  final isLoading = false.obs;
  final _submissionRepository = Get.put(SubmissionRepository()); // Adjust repository reference
  RxList<SubmissionModel> allSubmission = <SubmissionModel>[].obs;


  Future<void> fetchAssignment(String classCode, String assignmentId) async {
    try {
      isLoading.value = true;
      String token = await Apis().getToken();
      if (token != '') {
        final submission = await _submissionRepository.getAllSubmission(classCode, assignmentId);
        allSubmission.assignAll(submission);
        print("All: $submission");
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
