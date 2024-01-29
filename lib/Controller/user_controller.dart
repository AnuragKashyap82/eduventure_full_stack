import 'package:eduventure_nodejs/apis/apis.dart';
import 'package:get/get.dart';

import '../Model/user_model.dart';
import '../Repository/user_repository.dart';

class UserController extends GetxController {
  Rx<UserModel> userData = UserModel.empty().obs;
  static UserController get instance => Get.find();

  final isLoading = false.obs;
  final _userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      String token = await Apis().getToken();
      if (token != '') {
        final data = await _userRepository.fetchUserData(token);
        isLoading.value = false;
        userData.value = data;
      }else{

      }
    } catch (e) {
      print(e.toString());
      isLoading.value = false;
    }
  }
}
