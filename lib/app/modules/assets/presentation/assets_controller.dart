import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tree_view_desafio/app/modules/assets/domain/usecases/list_data.dart';

import '../data/assets_repository.dart';
import '../domain/usecases/populate_data.dart';

class AssetsController extends GetxController {
  List<Item> assets = [];
  final IAssetsRepository repository;
  final IPopulateData populateData;
  final IListData listData;
  bool isLoading = true;

  AssetsController(this.repository, this.populateData, this.listData);

  Future<void> getAssets() async {
    assets = await listData();
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
  // final String response = await rootBundle.loadString('assets/jaguar_unit_json/assets.json');
  // final data = await json.decode(response);

  // print(data.map<AssetsModel>((json) => AssetsModel.fromMap(json)).toList());

  // return data.map<AssetsModel>((json) => AssetsModel.fromMap(json)).toList();
}
