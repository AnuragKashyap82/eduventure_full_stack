import 'package:eduventure_nodejs/Controller/user_controller.dart';
import 'package:get/get.dart';
import '../Model/time_table_model.dart';
import '../Repository/time_table_faculty_reepository.dart';
import '../apis/apis.dart';

class FacultyTimeTableControllerController extends GetxController {
  static FacultyTimeTableControllerController get instance => Get.find();

  final UserController userController = Get.find();

  final isLoading = false.obs;
  final _facultyTimeTableRepository = Get.put(TimetableFacultyRepository());
  RxList<TimetableModel> mondayTimeTable = <TimetableModel>[].obs;
  RxList<TimetableModel> tuesdayTimeTable = <TimetableModel>[].obs;
  RxList<TimetableModel> wednesdayTimeTable = <TimetableModel>[].obs;
  RxList<TimetableModel> thursdayTimeTable = <TimetableModel>[].obs;
  RxList<TimetableModel> fridayTimeTable = <TimetableModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchTimeTable();
    super.onInit();
  }


  Future<void> fetchTimeTable() async {
      try {
        isLoading.value = true;
        String token = await Apis().getToken();
        if (token != '') {
          final timeTable = await _facultyTimeTableRepository.getAllFacultyTimeTable(token, userController.userData().studentId); // Adjust repository method

          ///Filter by day
          final filteredTimeTable = timeTable.where((anurag) => anurag.dayName == "Monday").toList();
          mondayTimeTable.assignAll(filteredTimeTable);

          print("DATA: [$mondayTimeTable]");

          ///Filter by day
          final filteredTuesTimeTable = timeTable.where((anurag) => anurag.dayName == "Tuesday").toList();
          tuesdayTimeTable.assignAll(filteredTuesTimeTable);

          ///Filter by day
          final filteredWedTimeTable = timeTable.where((anurag) => anurag.dayName == "Wednesday").toList();
          wednesdayTimeTable.assignAll(filteredWedTimeTable);

          ///Filter by day
          final filteredThurTimeTable = timeTable.where((anurag) => anurag.dayName == "Thursday").toList();
          thursdayTimeTable.assignAll(filteredThurTimeTable);

          ///Filter by day
          final filteredFriTimeTable = timeTable.where((anurag) => anurag.dayName == "Friday").toList();
          fridayTimeTable.assignAll(filteredFriTimeTable);
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
