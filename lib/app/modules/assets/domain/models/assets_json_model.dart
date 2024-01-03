// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AssetsJsonModel {
  String name;
  String id;
  String? locationId;
  String? parentId;
  String? sensorType;
  String? status;

  AssetsJsonModel({
      required this.name,
      required this.id,
      this.locationId,
      this.parentId,
      this.sensorType,
      this.status,
});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'locationId': locationId,
      'parentId': parentId,
      'sensorType': sensorType,
      'status': status,
    };
  }

  factory AssetsJsonModel.fromMap(Map<String, dynamic> map) {
    return AssetsJsonModel(
      name: map['name'] as String,
      id: map['id'] as String,
      locationId: map['locationId'] as String?,
      parentId: map['parentId'] as String?,
      sensorType: map['sensorType'] as String?,
      status: map['status'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetsJsonModel.fromJson(String source) => AssetsJsonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssetsModel(name: $name, id: $id, locationId: $locationId, parentId: $parentId, sensorType: $sensorType, status: $status)';
  }
}
