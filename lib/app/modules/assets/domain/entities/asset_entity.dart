// ignore_for_file: public_member_api_docs, sort_constructors_first
class AssetEntity {
  final String name;
  final String id;
  final String? locationId;
  final String? parentId;
  final String? sensorType;
  final String? status;
  final String? unit;

  AssetEntity({
    required this.name,
    required this.id,
    this.locationId,
    this.parentId,
    this.sensorType,
    this.status,
    this.unit,
  });

  factory AssetEntity.fromMap(json) {
    return AssetEntity(
      name: json['name'],
      id: json['id'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorType: json['sensorType'],
      status: json['status'],
      // unit: json['unit'],
    );
  }

  AssetEntity copyWith({
    String? name,
    String? id,
    String? locationId,
    String? parentId,
    String? sensorType,
    String? status,
    String? unit,
  }) {
    return AssetEntity(
      name: name ?? this.name,
      id: id ?? this.id,
      locationId: locationId ?? this.locationId,
      parentId: parentId ?? this.parentId,
      sensorType: sensorType ?? this.sensorType,
      status: status ?? this.status,
      unit: unit ?? this.unit,
    );
  }
}
