
import 'package:get/get.dart';

import '../Model/result_model.dart';
import '../Repository/result_repository.dart';
import '../apis/apis.dart';

class ResultController extends GetxController {
  static ResultController get instance => Get.find();

  final isLoading = false.obs;
  final _resultRepository = Get.put(ResultRepository()); // Adjust repository reference
  RxList<ResultModel> allResults = <ResultModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchResults("CSE", "7th Semester");
    super.onInit();
  }

  Future<void> fetchResults(String branch, String semester) async {
    try {
      isLoading.value = true;
      String token = await Apis().getToken();
      if (token != '') {
        final results = await _resultRepository.getAllResult(token); // Adjust repository method

        final filteredResults = results
            .where((result) =>
        result.semester == semester && result.branch == branch)
            .toList();
        allResults.assignAll(filteredResults);
        print('Response status code: ${allResults}');
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
