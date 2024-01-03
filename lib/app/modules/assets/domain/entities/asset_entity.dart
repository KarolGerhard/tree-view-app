class AssetEntity {
  final String name;
  final String id;
  final String? locationId;
  final String? parentId;
  final String? sensorType;
  final String? status;

  AssetEntity({
    required this.name,
    required this.id,
    this.locationId,
    this.parentId,
    this.sensorType,
    this.status,
  });

  factory AssetEntity.fromMap(json) {
    return AssetEntity(
      name: json['name'],
      id: json['id'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorType: json['sensorType'],
      status: json['status'],
    );
  }
}
