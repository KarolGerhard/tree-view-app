import 'package:tree_view_desafio/app/modules/assets/domain/models/asset_model.dart';

import '../models/button_filter_type.dart';
import '../models/item_model.dart';

abstract class IFilterData {
  Future<List<Item>> call(List<Item> items, FilterOptions options);
}

class FilterData implements IFilterData {
  @override
  Future<List<Item>> call(List<Item> items, FilterOptions options) async {
    return items
        .where((item) => FilterBuilder(filterOptions: options).build(item))
        .toList();
  }
}

class FilterOptions {
  final String? name;
  final ButtonFilterType? buttonFilterType;

  FilterOptions({this.name, this.buttonFilterType});
}

class FilterBuilder {
  FilterOptions filterOptions;

  FilterBuilder({required this.filterOptions});

  build(Item item) {
    bool result = true;

    if (filterOptions.buttonFilterType == ButtonFilterType.critical) {
      result =  _isCritical(item);
    }
    if (filterOptions.buttonFilterType == ButtonFilterType.sensor) {
      result = _isSensor(item);
    }
    if (filterOptions.name != null && filterOptions.name!.isNotEmpty) {
      result = !result ? _namePredicate(item) : result && _namePredicate(item);
    }

    return result;
  }

  _namePredicate(Item item) {
    final name = filterOptions.name!.toLowerCase();
    return item.name.toLowerCase().contains(name) &&
        item.subItems.any(
          (subItem) =>
              subItem.name.toLowerCase().contains(name) &&
              subItem.subItems.any(
                (subSubItem) =>
                    subSubItem.name.toLowerCase().contains(name) &&
                    subSubItem.subItems.any(
                      (subSubSubItem) =>
                          subSubSubItem.name.toLowerCase().contains(name),
                    ),
              ),
        );
  }

  _isCritical(Item item) {
    return (item is Asset &&
            item.status != null &&
            item.status!.toLowerCase().contains('alert')) ||
        item.subItems.any((subItem) =>
            subItem is Asset &&
                subItem.status != null &&
                subItem.status!.toLowerCase().contains('alert') ||
            subItem.subItems.any((subSubItem) =>
                subSubItem is Asset &&
                    subSubItem.status != null &&
                    subSubItem.status!.toLowerCase().contains('alert') ||
                subSubItem.subItems.any((subSubSubItem) =>
                    subSubSubItem is Asset &&
                    subSubSubItem.status != null &&
                    subSubSubItem.status!.toLowerCase().contains('alert'))));
  }

  _isSensor(Item item) {
    return (item is Asset && item.sensorType != null) ||
        item.subItems.any((subItem) =>
            (subItem is Asset && subItem.sensorType != null) ||
            subItem.subItems.any((subSubItem) =>
                (subSubItem is Asset && subSubItem.sensorType != null) ||
                subSubItem.subItems.any((subSubSubItem) =>
                    (subSubSubItem is Asset &&
                        subSubSubItem.sensorType != null))));
  }
}

