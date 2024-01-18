import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/assets_repository.dart';
import '../domain/models/filter_options.dart';
import '../domain/models/item_model.dart';
import '../domain/usecases/filter_data.dart';
import '../domain/usecases/list_data.dart';
import '../domain/usecases/populate_data.dart';

class AssetsController extends GetxController {
  List<Item> assets = [];
  List<Item> fulllData = [];

  final IAssetsRepository repository;
  final IPopulateData populateData;
  final IListData listData;
  final IFilterData filterData;
  bool isLoading = true;
  String? unit;
  

  AssetsController(
      this.repository, this.populateData, this.listData, this.filterData);

  Future<void> getAssets() async {
    assets = await listData(unit!);
    fulllData = assets;
    if (assets.isNotEmpty) {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    unit = Get.arguments;
    super.onInit();
    populateData(unit!).then((value) => getAssets());
  }

  search(FilterOptions options) async {
    assets = await filterData(fulllData, options);
    update();
  }
}
