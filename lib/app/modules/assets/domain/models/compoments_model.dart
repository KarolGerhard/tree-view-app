import '../entities/asset_entity.dart';
import 'asset_model.dart';
import 'item_model.dart';

class Component extends Asset {
  Component(
    String id,
    String name,
    String? locationId,
    String? sensorType,
    String? status, {
    super.parentId,
  }) : super(id, name, locationId, sensorType, status);
  factory Component.fromEntity(AssetEntity assetEntity) {
    return Component(
      assetEntity.id,
      assetEntity.name,
      assetEntity.locationId,
      assetEntity.sensorType,
      assetEntity.status,
      parentId: assetEntity.parentId,
    );
  }

  @override
  Component copy() {
    return Component(
      id,
      name,
      locationId,
      sensorType,
      status,
      parentId: parentId,
    );
  }

  @override
  Component copyWith({
    String? id,
    String? name,
    String? locationId,
    String? sensorType,
    String? status,
    List<Item>? subItens,
  }) {
    return Component(
      id ?? this.id,
      name ?? this.name,
      locationId ?? this.locationId,
      sensorType ?? this.sensorType,
      status ?? this.status,
    );
  }
}