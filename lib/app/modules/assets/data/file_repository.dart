import 'dart:convert';

import 'package:flutter/services.dart' as root_bundle;
import 'package:tree_view_desafio/app/modules/assets/domain/entities/asset_entity.dart';
import 'package:tree_view_desafio/app/modules/assets/domain/entities/local_entity.dart';

abstract class IFileRepository {
  Future<List<AssetEntity>> getAssetsFromFile();
  Future<List<LocalEntity>> getLocationsFromFile();
}

class FileRepository implements IFileRepository {

  @override
  Future<List<AssetEntity>> getAssetsFromFile() async {
    final String response = await root_bundle.rootBundle
        .loadString('assets/jaguar_unit_json/assets.json');
    final data = await json.decode(response);

    return data
        .map<AssetEntity>((json) => AssetEntity.fromMap(json))
        .toList();
  }

  @override
  Future<List<LocalEntity>> getLocationsFromFile() async {
    final String response = await root_bundle.rootBundle
        .loadString('assets/jaguar_unit_json/locations.json');
    final data = await json.decode(response);

    return data
        .map<LocalEntity>((json) => LocalEntity.fromMap(json))
        .toList();
  }
}
