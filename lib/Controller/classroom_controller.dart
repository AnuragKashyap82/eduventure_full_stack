import 'package:get/get.dart';

import '../Model/classroom_model.dart';
import '../Repository/classroom_repository.dart';
import '../apis/apis.dart';

class ClassroomController extends GetxController {
  static ClassroomController get instance => Get.find();

  final isLoading = false.obs;
  final _classroomRepository = Get.put(ClassroomRepository()); // Adjust repository reference
  RxList<ClassroomModel> allClassrooms = <ClassroomModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchClassrooms();
    super.onInit();
  }

  Future<void> fetchClassrooms() async {
    try {
      isLoading.value = true;

      String token = await Apis().getToken();
      if (token != '') {
        final classrooms = await _classroomRepository.getMyClassroom(token);
        // Filter all Classrooms
        allClassrooms.assignAll(classrooms);
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
