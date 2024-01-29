import 'package:get/get.dart';
import '../Model/notice_model.dart';
import '../Repository/notice_repository.dart';
import '../apis/apis.dart';

class NoticeController extends GetxController {
  static NoticeController get instance => Get.find();

  final isLoading = false.obs;
  final _noticeRepository = Get.put(NoticeRepository()); // Adjust repository reference
  RxList<NoticeModel> allNotices = <NoticeModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchNotices();
    super.onInit();
  }

  Future<void> fetchNotices() async {
    try {
      isLoading.value = true;
      String token = await Apis().getToken();
      if (token != '') {
        final notices = await _noticeRepository.getAllNotices(token); // Adjust repository method
        // Filter all Notices
        allNotices.assignAll(notices);
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
