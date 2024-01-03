class LocalEntity {
  final String name;
  final String id;
  final String? parentId;

  LocalEntity({required this.name, required this.id, this.parentId});

  factory LocalEntity.fromMap(json) {
    return LocalEntity(
      name: json['name'],
      id: json['id'],
      parentId: json['parentId'],
    );
  }
}
