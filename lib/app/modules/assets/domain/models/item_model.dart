import 'package:tree_view_desafio/app/modules/assets/domain/models/asset_model.dart';
import 'package:tree_view_desafio/app/modules/assets/domain/models/compoments_model.dart';

class Item {
  final String id;
  final String name;
  final String? parentId;
  final List<Item> _subItems = [];
  List<Item> get subItems => _subItems;

  Item(this.id, this.name, {this.parentId});

  void addItems(List<Item> items) {
    _subItems.addAll(items);
  }

  void addIfNotExists(Item item) {
    if (!subItems.any((element) => element.id == item.id)) {
      _subItems.add(item);
    }
  }

  bool get isSensor {
    return (this is Asset &&
            (this as Asset).sensorType != null &&
            (this as Asset).sensorType == "energy" &&
            (this as Asset).status!.toLowerCase().contains('operating')) ||
        (this is Component &&
            (this as Component).sensorType != null &&
            (this as Component).status!.toLowerCase().contains('operating'));
  }

  bool get isCritical {
    return (this is Asset &&
            (this as Asset).status != null &&
            (this as Asset).status!.toLowerCase().contains('alert')) ||
        (this is Component &&
            (this as Component).status != null &&
            (this as Asset).status!.toLowerCase().contains('alert'));
  }

  bool isSameName(String name) {
    return this.name.toLowerCase().contains(name.toLowerCase());
  }

  bool get hasParent {
    return parentId != null && parentId!.isNotEmpty;
  }

  Item copy() {
    return Item(id, name, parentId: parentId);
  }

  Item copyWith({
    String? id,
    String? name,
    List<Item>? subItens,
  }) {
    return Item(
      id ?? this.id,
      name ?? this.name,
    )..subItems.addAll(subItens!);
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}