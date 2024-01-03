import 'package:get/get.dart';
import 'package:tree_view_desafio/app/modules/assets/data/database_helper.dart';
import 'package:tree_view_desafio/app/modules/assets/data/local_repository.dart';

import '../assets/data/assets_repository.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DatabaseHelper(), fenix: true);
    Get.lazyPut<IAssetsRepository>(() => AssetsRepository(Get.find()));
    Get.lazyPut<ILocalRepository>(() => LocalRepository(Get.find()));
    Get.lazyPut<HomeController>(() {
      return HomeController();
    });
  }
}
