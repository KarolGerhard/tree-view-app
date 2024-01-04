import '../models/filter_options.dart';
import '../models/item_model.dart';

abstract class IFilterData {
  Future<List<Item>> call(List<Item> items, FilterOptions options);
}

class FilterData implements IFilterData {
 @override
  Future<List<Item>> call(List<Item> items, FilterOptions options) async {
    if (options.hasNoFilter) return items;

    Map<String, Item> acumulador = <String, Item>{};
    Set<Item> result = {};

    _filterItems(options, items, result, acumulador);
    Map<String, Item> pushedItems = {};
    return result
        .map((item) => _findParent(acumulador, pushedItems, item))
        .toSet()
        .toList();
  }

  Item _findParent(
    Map<String, Item> allItems,
    Map<String, Item> pushedParents,
    Item current,
  ) {
    if (!current.hasParent) return current;

    final parent = allItems[current.parentId];
    pushedParents[parent!.id] ??= parent.copy();
    final copyParent = pushedParents[parent.id]!..addIfNotExists(current);

    if (copyParent.hasParent) {
      final granfather = _findParent(allItems, pushedParents, copyParent);
      if (granfather.subItems.length > 1) {
        return pushedParents[granfather.id]!..addIfNotExists(copyParent);
      }
      return granfather;
    }

    return copyParent;
  }

  void _filterItems(FilterOptions options, List<Item> items, Set<Item> result,
      Map<String, Item> acumulador) {
    for (var item in items) {
      acumulador[item.id] = item;
      _filterItem(options, item, result);
      if (item.subItems.isNotEmpty) {
        _filterItems(options, item.subItems, result, acumulador);
      }
    }
  }

  void _filterItem(FilterOptions options, Item item, Set<Item> result) {
    if (options.hasName && item.isSameName(options.name!)) {
      result.add(item.copy());
    }
    if (options.hasSensorSelected && item.isSensor) {
      result.add(item.copy());
    }
    if (options.hasCriticalSelected && item.isCritical) {
      result.add(item.copy());
    }
  }
}
