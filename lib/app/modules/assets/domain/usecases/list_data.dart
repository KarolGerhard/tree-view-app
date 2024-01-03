import 'package:tree_view_desafio/app/modules/assets/data/assets_repository.dart';
import 'package:tree_view_desafio/app/modules/assets/data/local_repository.dart';
import 'package:tree_view_desafio/app/modules/assets/domain/entities/asset_entity.dart';
import 'package:tree_view_desafio/app/modules/assets/domain/entities/local_entity.dart';

abstract class IListData {
  Future<List<Item>> call();
}

class ListData implements IListData {
  final ILocalRepository localRepository;
  final IAssetsRepository assetRepository;

  ListData(this.localRepository, this.assetRepository);

  @override
  Future<List<Item>> call() async {
    List<Item> items = [];

    List<LocalEntity> locals =
        await localRepository.getLocationsWithoutParent();

    for (LocalEntity localEntity in locals) {
      final local = Local(localEntity.id, localEntity.name);

      local.subLocals = await getAllSubLocals(localEntity);
      local.assets = await getAllSubAssets(localEntity);

      items.add(local);
    }

    List<AssetEntity> assetsWithoutParentAndLocation =
        await assetRepository.getAssetsWithoutParentAndLocation();
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
      final assets = await getAllSubAssets(localEntity);
      final local = Local(localEntity.id, localEntity.name);
      local.assets = assets;
      locals.add(local);
    }
    return locals;
  }

  Future<List<Asset>> getAllSubAssets(LocalEntity localEntity) async {
    List<Asset> assets = [];

    List<AssetEntity> assetsEntity =
        await assetRepository.getAssetsByLocationId(localEntity.id);

    for (AssetEntity assetEntity in assetsEntity) {
      final subAssets =
          await assetRepository.getAssetsByParentId(assetEntity.id);
      final asset = Asset.fromEntity(assetEntity);
      asset.subAssets = subAssets
          .where((element) => element.sensorType == null)
          .map((e) => Asset.fromEntity(e))
          .toList();
      asset.components = subAssets
          .where((element) => element.sensorType != null)
          .map((e) => Component.fromEntity(e))
          .toList();
      getAllSubComponents(asset);
      assets.add(asset);
    }
    return assets;
  }

  Future getAllSubComponents(Asset asset) async {
    for (Asset subAsset in asset.subAssets) {
      final subComponents =
          await assetRepository.getAssetsByParentId(subAsset.id);
      subAsset.components = subComponents
          .where((element) => element.sensorType != null)
          .map((e) => Component.fromEntity(e))
          .toList();
    }
  }
}

class Item {
  final String id;
  final String name;

  Item(this.id, this.name);
}

class Local extends Item {
  List<Asset> assets;
  List<Local> subLocals;

  List<Item> get subItems {
    List<Item> subItems = [];
    subItems.addAll(assets);
    subItems.addAll(subLocals);
    return subItems;
  }

  Local(String id, String name)
      : assets = [],
        subLocals = [],
        super(id, name);
}

class Asset extends Item {
  final String? locationId;
  List<Asset> subAssets;
  List<Component> components;
  final String? sensorType;
  final String? status;

  Asset(String id, String name, this.locationId, this.sensorType, this.status)
      : subAssets = [],
        components = [],
        super(id, name);

  factory Asset.fromEntity(AssetEntity assetEntity) {
    return Asset(
      assetEntity.id,
      assetEntity.name,
      assetEntity.locationId,
      assetEntity.sensorType,
      assetEntity.status,
    );
  }
}

class Component extends Asset {
  Component(String id, String name, String? locationId, String? sensorType,
      String? status)
      : super(id, name, locationId, sensorType, status);
  factory Component.fromEntity(AssetEntity assetEntity) {
    return Component(
      assetEntity.id,
      assetEntity.name,
      assetEntity.locationId,
      assetEntity.sensorType,
      assetEntity.status,
    );
  }
}
