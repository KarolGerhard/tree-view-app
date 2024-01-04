import 'package:sqflite/sqflite.dart';
import 'package:tree_view_desafio/app/modules/assets/data/database_helper.dart';
import 'package:tree_view_desafio/app/modules/assets/domain/entities/asset_entity.dart';

abstract class IAssetsRepository {
  Future<void> saveAssets(List<AssetEntity> assets);
  Future<List<AssetEntity>> getAssetsByParentId(String parentId);
  Future<List<AssetEntity>> getAssetsByLocationId(String locationId);
  Future<List<AssetEntity>> getAssetsWithoutParentAndLocation(String unit);
  Future<bool> isDatabaseEmpty(String unit);
}

class AssetsRepository implements IAssetsRepository {
  final DatabaseHelper dbHelper;

  AssetsRepository(this.dbHelper);

  @override
  Future<void> saveAssets(List<AssetEntity> assets) async {
    final batch = (await dbHelper.database).batch();
    for (var asset in assets) {
      batch.insert('AssetEntity', {
        'id': asset.id,
        'name': asset.name,
        'locationId': asset.locationId,
        'parentId': asset.parentId,
        'sensorType': asset.sensorType,
        'status': asset.status,
        'unit': asset.unit,
      });
    }
    await batch.commit();
  }

  @override
  Future<List<AssetEntity>> getAssetsByParentId(String parentId) async {
    final List<Map<String, dynamic>> maps =
        await (await dbHelper.database).query(
      'AssetEntity',
      where: 'parentId = ?',
      whereArgs: [parentId],
    );
    return List.generate(maps.length, (i) {
      return AssetEntity(
        id: maps[i]['id'],
        name: maps[i]['name'],
        locationId: maps[i]['locationId'],
        parentId: maps[i]['parentId'],
        sensorType: maps[i]['sensorType'],
        status: maps[i]['status'],
      );
    });
  }

  @override
  Future<List<AssetEntity>> getAssetsByLocationId(String locationId) async {
    final database = await dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await database.query(
      'AssetEntity',
      where: 'locationId = ?',
      whereArgs: [locationId],
    );
    return List.generate(maps.length, (i) {
      return AssetEntity(
        id: maps[i]['id'],
        name: maps[i]['name'],
        locationId: maps[i]['locationId'],
        parentId: maps[i]['parentId'],
        sensorType: maps[i]['sensorType'],
        status: maps[i]['status'],
      );
    });
  }

  @override
  Future<List<AssetEntity>> getAssetsWithoutParentAndLocation(String unit) async {
    final List<Map<String, dynamic>> maps =
        await (await dbHelper.database).query(
      'AssetEntity',
      where: 'parentId IS NULL AND locationId IS NULL AND unit = ?',
      whereArgs: [unit],
    );
    return List.generate(maps.length, (i) {
      return AssetEntity(
        id: maps[i]['id'],
        name: maps[i]['name'],
        locationId: maps[i]['locationId'],
        parentId: maps[i]['parentId'],
        sensorType: maps[i]['sensorType'],
        status: maps[i]['status'],
        unit: maps[i]['unit'],
      );
    });
  }

  @override
  Future<bool> isDatabaseEmpty(String unit) async {
    final count = Sqflite.firstIntValue(await (await dbHelper.database)
        .rawQuery('SELECT COUNT(*) FROM AssetEntity WHERE unit = ?', [unit]));
    return count == 0;
  }
}
