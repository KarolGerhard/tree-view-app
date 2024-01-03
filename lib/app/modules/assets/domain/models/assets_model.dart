import 'assets_json_model.dart';
import 'item_model.dart';

class AssetsModel extends ItemModel {
  String? locationId;
  String? parentId;
  String? sensorType;
  String? status;

  AssetsModel({
    required String id,
    required String name,
    this.locationId,
    this.sensorType,
    this.status,
  }) : super(id, name);

  factory AssetsModel.fromJsonModel(AssetsJsonModel asset) {
    return AssetsModel(
      id: asset.id,
      name: asset.name,
      locationId: asset.locationId,
      sensorType: asset.sensorType,
      status: asset.status,
    );
  }

   List<AssetsModel>? get subAssets {
    return subItems as List<AssetsModel>?;
  }

  Future addSubAsset(AssetsModel subAsset) async {
    subAssets!.add(subAsset);
  }

  @override
  String toString() {
    return 'AssetsModel(name: $name, id: $id, locationId: $locationId, parentId: $parentId, sensorType: $sensorType, status: $status)';
  }
}
