import 'dart:convert';

import 'package:eduventure_nodejs/Model/material_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';


class MaterialRepository extends GetxController {
  static MaterialRepository get instance => Get.find();

  Future<List<MaterialModel>> getAllMaterial(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}getAllMaterial'),
        headers: {
          'x-auth-token': token,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> materialData = json.decode(response.body)['material'];
        final List<MaterialModel> material = materialData
            .map((materialData) => MaterialModel.fromJson(materialData))
            .toList();

        return material;
      } else {
        throw "Failed to load material: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
