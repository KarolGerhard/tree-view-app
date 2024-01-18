import 'dart:convert';
import 'package:flutter/services.dart' as root_bundle;

import '../domain/entities/asset_entity.dart';
import '../domain/entities/local_entity.dart';

abstract class IFileRepository {
  Future<List<AssetEntity>> getAssetsFromFile(String unit);
  Future<List<LocalEntity>> getLocationsFromFile(String unit);
}

class FileRepository implements IFileRepository {
  Map<String, String> units = {
    'jaguar': 'assets/jaguar_unit_json/',
    'tobias': 'assets/tobias_unit_json/',
    'apex': 'assets/apex_unit_json/',
  };

  @override
  Future<List<AssetEntity>> getAssetsFromFile(String unit) async {
    final String response =
        await root_bundle.rootBundle.loadString('${units[unit]!}assets.json');
    final data = await json.decode(response);

    return data
        .map<AssetEntity>(
            (json) => AssetEntity.fromMap(json).copyWith(unit: unit))
        .toList();
  }

  @override
  Future<List<LocalEntity>> getLocationsFromFile(String unit) async {
    final String response = await root_bundle.rootBundle
        .loadString('${units[unit]!}locations.json');
    final data = await json.decode(response);

    return data.map<LocalEntity>((json) => LocalEntity.fromMap(json).copyWith(unit: unit)).toList();
  }
}
