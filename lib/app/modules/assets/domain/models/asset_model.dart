import '../entities/asset_entity.dart';
import 'compoments_model.dart';
import 'item_model.dart';

class Asset extends Item {
  final String? locationId;
  List<Asset> subAssets;
  List<Component> components;
  final String? sensorType;
  final String? status;

  @override
  List<Item> get subItems {
    if (super.subItems.isNotEmpty) return super.subItems;

    super.subItems.addAll(subAssets);
    super.subItems.addAll(components);
    return super.subItems;
  }

  Asset(String id, String name, this.locationId, this.sensorType, this.status,
      {super.parentId})
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
      parentId: assetEntity.locationId ?? assetEntity.parentId,
    );
  }

  @override
  Asset copy() {
    return Asset(id, name, locationId, sensorType, status, parentId: parentId);
  }

  @override
  Asset copyWith({
    String? id,
    String? name,
    String? locationId,
    String? sensorType,
    String? status,
    List<Item>? subItens,
  }) {
    return Asset(
      id ?? this.id,
      name ?? this.name,
      locationId ?? this.locationId,
      sensorType ?? this.sensorType,
      status ?? this.status,
    );
  }
}
