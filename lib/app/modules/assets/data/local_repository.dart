import 'package:sqflite/sqflite.dart';

import '../domain/entities/local_entity.dart';
import 'database_helper.dart';

abstract class ILocalRepository {
  Future<void> saveLocations(List<LocalEntity> locations);
  Future<List<LocalEntity>> getLocations();
  Future<LocalEntity?> getLocationById(int id);
  Future<List<LocalEntity>> getLocationsWithoutParent(String unit);
  Future<List<LocalEntity>> getLocationsByParentId(String parentId);
  Future<bool> isDatabaseEmpty(String unit);
}

class LocalRepository implements ILocalRepository {
  final DatabaseHelper dbHelper;

  LocalRepository(this.dbHelper);

  @override
  Future<void> saveLocations(List<LocalEntity> locations) async {
    final batch = (await dbHelper.database).batch();
    for (var location in locations) {
      batch.insert('LocalEntity', {
        'id': location.id,
        'name': location.name,
        'parentId': location.parentId,
        'unit': location.unit,
      });
    }
    await batch.commit();
  }

  @override
  Future<List<LocalEntity>> getLocationsByParentId(String parentId) async {
    final database = await dbHelper.database;
    final List<Map> maps =
        await database.query(
      'LocalEntity',
      where: 'parentId = ?',
      whereArgs: [parentId],
    );
    return List.generate(maps.length, (i) {
      return LocalEntity(
        id: maps[i]['id'],
        name: maps[i]['name'],
        parentId: maps[i]['parentId'],
      );
    });
  }

  @override
  Future<List<LocalEntity>> getLocationsWithoutParent(String unit) async {
    final List<Map<String, dynamic>> maps =
        await (await dbHelper.database).query(
      'LocalEntity',
      where: 'parentId IS NULL AND unit = ?',
      whereArgs: [unit],
    );
    return List.generate(maps.length, (i) {
      return LocalEntity(
        id: maps[i]['id'],
        name: maps[i]['name'],
        parentId: maps[i]['parentId'],
        unit: maps[i]['unit'],
      );
    });
  }

  @override
  Future<List<LocalEntity>> getLocations() async {
    final List<Map<String, dynamic>> maps =
        await (await dbHelper.database).query('LocalEntity');
    return List.generate(maps.length, (i) {
      return LocalEntity(
        id: maps[i]['id'],
        name: maps[i]['name'],
        parentId: maps[i]['parentId'],
      );
    });
  }

  @override
  Future<LocalEntity?> getLocationById(int id) async {
    final List<Map<String, dynamic>> maps =
        await (await dbHelper.database).query(
      'LocalEntity',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return LocalEntity(
        id: maps[0]['id'],
        name: maps[0]['name'],
        parentId: maps[0]['parentId'],
      );
    }
    return null;
  }

  @override
  Future<bool> isDatabaseEmpty(String unit) async {
    final count = Sqflite.firstIntValue(await (await dbHelper.database)
        .rawQuery('SELECT COUNT(*) FROM LocalEntity WHERE unit = ?', [unit]));
    return count == 0;
  }
}
