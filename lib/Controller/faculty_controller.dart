import 'package:get/get.dart';

import '../Model/user_model.dart';
import '../Repository/faculty_repositiory.dart';
import '../apis/apis.dart';

class FacultyController extends GetxController {
  static FacultyController get instance => Get.find();

  final isLoading = false.obs;
  final _noticeRepository = Get.put(FacultyRepository()); // Adjust repository reference
  RxList<UserModel> allFaculties = <UserModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchFaculty();
    super.onInit();
  }

  Future<void> fetchFaculty() async {
    try {
      isLoading.value = true;

      String token = await Apis().getToken();
      if (token != '') {
        final faculty = await _noticeRepository.getAllFaculty(token); // Adjust repository method

        // Filter all Notices
        allFaculties.assignAll(faculty);
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
