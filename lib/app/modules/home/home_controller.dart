// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import '../assets/data/assets_repository.dart';
import '../assets/domain/models/assets_model.dart';

class HomeController extends GetxController {
  List<AssetsModel> assets = [];

  HomeController();

  @override
  void onInit() {
    super.onInit();
  }
  // final String response = await rootBundle.loadString('assets/jaguar_unit_json/assets.json');
  // final data = await json.decode(response);

  // print(data.map<AssetsModel>((json) => AssetsModel.fromMap(json)).toList());

  // return data.map<AssetsModel>((json) => AssetsModel.fromMap(json)).toList();
}
