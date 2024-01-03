import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tree_view_desafio/app/modules/assets/domain/usecases/filter_data.dart';
import 'package:tree_view_desafio/app/modules/assets/domain/usecases/list_data.dart';

import '../data/assets_repository.dart';
import '../domain/models/item_model.dart';
import '../domain/usecases/populate_data.dart';

class AssetsController extends GetxController {
  List<Item> assets = [];
  List<Item> fulllData = [];

  final IAssetsRepository repository;
  final IPopulateData populateData;
  final IListData listData;
  final IFilterData filterData;
  bool isLoading = true;

  AssetsController(
      this.repository, this.populateData, this.listData, this.filterData);

  Future<void> getAssets() async {
    assets = await listData();
    fulllData = assets;
    if (assets.isNotEmpty) {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    populateData().then((value) => getAssets());
  }

  search(FilterOptions options) async {
    assets = await filterData(fulllData, options);
    update();
  }
}
