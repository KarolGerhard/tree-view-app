import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LocationsJsonModel {
  String name;
  String id;  
  String? parentId;


  LocationsJsonModel({
    required this.name,
    required this.id,
    this.parentId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'parentId': parentId,
    };
  }

  factory LocationsJsonModel.fromMap(Map<String, dynamic> map) {
    return LocationsJsonModel(
      name: map['name'] as String,
      id: map['id'] as String,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationsJsonModel.fromJson(String source) => LocationsJsonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LocationsModel(name: $name, id: $id, parentId: $parentId)';
}
