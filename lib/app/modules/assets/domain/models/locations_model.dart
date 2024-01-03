
import 'assets_model.dart';
import 'item_model.dart';

class LocationModel extends ItemModel {
  String? parentId;


  LocationModel(String id, String name, {super.parentId}) : super(id, name);

  List<AssetsModel>? get assets {
    return subItems?.where((item) => item is AssetsModel).toList() as List<AssetsModel>?;
  }

  List<LocationModel>? get subLocals {
    return subItems?.where((item) => item is LocationModel).toList() as List<LocationModel>?;
  }

  Future addAsset(AssetsModel asset) async {
    subItems!.add(asset);
  }

  Future addSubLocation(LocationModel location) async {
    subItems!.add(location);
  }

  @override
  String toString() =>
      'LocationModel(name: $name, id: $id, parentId: $parentId)';
}
