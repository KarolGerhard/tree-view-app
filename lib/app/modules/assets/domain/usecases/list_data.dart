import 'package:tree_view_desafio/app/modules/assets/data/assets_repository.dart';
import 'package:tree_view_desafio/app/modules/assets/data/local_repository.dart';
import 'package:tree_view_desafio/app/modules/assets/domain/entities/asset_entity.dart';
import 'package:tree_view_desafio/app/modules/assets/domain/entities/local_entity.dart';

import '../models/asset_model.dart';
import '../models/compoments_model.dart';
import '../models/item_model.dart';
import '../models/local_model.dart';

abstract class IListData {
  Future<List<Item>> call(String unit);
}

class ListData implements IListData {
  final ILocalRepository localRepository;
  final IAssetsRepository assetRepository;

  ListData(this.localRepository, this.assetRepository);

  @override
  Future<List<Item>> call(String unit) async {
    List<Item> items = [];

    List<LocalEntity> locals =
        await localRepository.getLocationsWithoutParent(unit);

    for (LocalEntity localEntity in locals) {
      final local = Local(localEntity.id, localEntity.name);

      local.addItems(await getAllSubLocals(localEntity));
      local.addItems(await getAllSubAssets(localEntity));

      items.add(local);
    }

    List<AssetEntity> assetsWithoutParentAndLocation =
        await assetRepository.getAssetsWithoutParentAndLocation(unit);
    var assetsWithoutParents = assetsWithoutParentAndLocation
        .map((e) => e.sensorType == null
            ? Asset.fromEntity(e)
            : Component.fromEntity(e))
        .toList();
    items.addAll(assetsWithoutParents);

    return items;
  }

  Future<List<Local>> getAllSubLocals(LocalEntity localEntity) async {
    List<Local> locals = [];
    List<LocalEntity> localsEntity =
        await localRepository.getLocationsByParentId(localEntity.id);
    for (LocalEntity localEntity in localsEntity) {
      final local = Local(localEntity.id, localEntity.name);
      local.addItems(await getAllSubAssets(localEntity));
      locals.add(local);
    }
    return locals;
  }

  Future<List<Asset>> getAllSubAssets(LocalEntity localEntity) async {
    List<Asset> assets = [];

    List<AssetEntity> assetsEntity =
        await assetRepository.getAssetsByLocationId(localEntity.id);

    for (AssetEntity assetEntity in assetsEntity) {
      final asset = Asset.fromEntity(assetEntity);
      final subAssets =
          await assetRepository.getAssetsByParentId(assetEntity.id);
      asset.addItems(subAssets
          .map<Item>((e) => e.sensorType == null
              ? Asset.fromEntity(e)
              : Component.fromEntity(e))
          .toList());
      getAllSubComponents(asset);
      assets.add(asset);
    }
    return assets;
  }

  Future getAllSubComponents(Asset asset) async {
    for (Asset subAsset in asset.subItems.whereType<Asset>()) {
      final subComponents =
          await assetRepository.getAssetsByParentId(subAsset.id);
      final parsedComponents = subComponents
          .where((element) => element.sensorType != null)
          .map((e) => Component.fromEntity(e))
          .toList();
      subAsset.addItems(parsedComponents);
    }
  }
}
