import 'package:get/get.dart';
import '../data/assets_repository.dart';
import '../data/file_repository.dart';
import '../data/local_repository.dart';
import '../domain/usecases/filter_data.dart';
import '../domain/usecases/list_data.dart';
import '../domain/usecases/populate_data.dart';
import '../presentation/assets_controller.dart';

class AssetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IFileRepository>(() => FileRepository());
    Get.lazyPut<IAssetsRepository>(() => AssetsRepository(Get.find()));
    Get.lazyPut<ILocalRepository>(() => LocalRepository(Get.find()));
    Get.lazyPut<IPopulateData>(
        () => PopulateData(Get.find(), Get.find(), Get.find()));
    Get.lazyPut<IListData>(() => ListData(Get.find(), Get.find()));
    Get.lazyPut<IFilterData>(() => FilterData());
    Get.lazyPut<AssetsController>(
        () => AssetsController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
