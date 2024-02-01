import 'package:eduventure_nodejs/Model/class_post_msg_model.dart';
import 'package:eduventure_nodejs/Repository/class_post_msg_repository.dart';
import 'package:get/get.dart';
import '../apis/apis.dart';

class ClassroomPostMsgController extends GetxController {
  static ClassroomPostMsgController get instance => Get.find();

  final isLoading = false.obs;
  final _classroomRepository = Get.put(ClassPostMsgRepository()); // Adjust repository reference
  RxList<PostMsgModel> allClassroomsMsg = <PostMsgModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> fetchClassrooms(String classCode) async {
    try {
      isLoading.value = true;

      String token = await Apis().getToken();
      if (token != '') {
        final classroomsMsg = await _classroomRepository.getAllClassMessage(classCode);
        // Filter all Classrooms
        allClassroomsMsg.assignAll(classroomsMsg);
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
