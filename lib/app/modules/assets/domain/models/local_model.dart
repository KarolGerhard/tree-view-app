import 'asset_model.dart';
import 'item_model.dart';

class Local extends Item {

  Local(String id, String name) : super(id, name);

  @override
  Local copyWith({
    String? id,
    String? name,
    List<Item>? subItens,
  }) {
    final local = Local(
      id ?? this.id,
      name ?? this.name,
    );

    if (subItens != null) {
      super.addItems(subItems);
    }

    return local;
  }
}
