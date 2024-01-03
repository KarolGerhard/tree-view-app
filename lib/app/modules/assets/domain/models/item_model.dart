class Item {
  final String id;
  final String name;
  final List<Item> _subItems = [];
  List<Item> get subItems => _subItems;

  Item(this.id, this.name);

  void addItems(List<Item> items) {
    _subItems.addAll(items);
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
}
