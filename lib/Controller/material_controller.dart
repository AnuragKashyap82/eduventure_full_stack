import 'package:get/get.dart';

import '../Model/material_model.dart';
import '../Repository/material_repository.dart';
import '../apis/apis.dart';

class MaterialController extends GetxController {
  static MaterialController get instance => Get.find();

  final isLoading = false.obs;
  final _materialRepository = Get.put(MaterialRepository()); // Adjust repository reference
  RxList<MaterialModel> allMaterials = <MaterialModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchMaterials("7th Semester", "CSE");
    super.onInit();
  }

  Future<void> fetchMaterials(String semester, String branch) async {
    try {
      isLoading.value = true;
      String token = await Apis().getToken();
      if (token != '') {
        final materials = await _materialRepository.getAllMaterial(token); // Adjust repository method

        final filteredMaterials = materials
            .where((material) =>
        material.semester == semester && material.branch == branch)
            .toList();
        allMaterials.assignAll(filteredMaterials);
        isLoading.value = false;
      }else{
        isLoading.value = false;
      }



    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
