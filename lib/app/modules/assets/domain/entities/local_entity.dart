// ignore_for_file: public_member_api_docs, sort_constructors_first
class LocalEntity {
  final String name;
  final String id;
  final String? parentId;
  final String? unit;

  LocalEntity({required this.name, required this.id, this.parentId, this.unit});

  factory LocalEntity.fromMap(json) {
    return LocalEntity(
      name: json['name'],
      id: json['id'],
      parentId: json['parentId']
    );
  }

  LocalEntity copyWith({
    String? name,
    String? id,
    String? parentId,
    String? unit,
  }) {
    return LocalEntity(
      name: name ?? this.name,
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      unit: unit ?? this.unit,
    );
  }
}
