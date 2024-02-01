import 'package:eduventure_nodejs/Model/student_model.dart';
import 'package:eduventure_nodejs/Repository/student_repository.dart';
import 'package:get/get.dart';
import '../apis/apis.dart';

class StudentController extends GetxController {
  static StudentController get instance => Get.find();

  final isLoading = false.obs;
  final _studentRepository = Get.put(StudentRepository()); // Adjust repository reference
  RxList<StudentModel> allStudent = <StudentModel>[].obs;


  Future<void> fetchStudent(String classCode) async {
    try {
      isLoading.value = true;
      String token = await Apis().getToken();
      if (token != '') {
        final student = await _studentRepository.getAllStudent(classCode);
        allStudent.assignAll(student);
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
