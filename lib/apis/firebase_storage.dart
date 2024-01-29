import 'dart:io';
import 'dart:typed_data';
import 'package:eduventure_nodejs/Controller/user_controller.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class Storage extends GetxController{
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  UserController userController = Get.find();
  RxBool isLoading = false.obs;

  // Future<void> uploadFile(
  //     String filePath,
  //     String fileName,
  //     ) async{
  //   File file = File(filePath);
  //   try{
  //     final  Reference storageReference = FirebaseStorage.instance.ref().child("Notices");
  //     UploadTask uploadTask = storageReference.putFile(file);
  //     String url = await (await uploadTask).ref.getDownloadURL();
  //   }on firebase_core.FirebaseException catch(e){
  //     print(e);
  //   }
  // }

  Future<String> uploadImageToStorage(Uint8List file) async {

    isLoading.value = true;
    Reference ref = storage.ref().child("profileImages").child(userController.userData().studentId);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    isLoading.value = false;
    return downloadUrl;

  }
}
