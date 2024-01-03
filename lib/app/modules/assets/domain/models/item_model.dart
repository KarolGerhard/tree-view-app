class ItemModel {
  String id;
  String name;
  List<ItemModel>? subItems = [];
  String? parentId;

  ItemModel(
    this.id,
    this.name,
    {this.parentId}
  );
}
