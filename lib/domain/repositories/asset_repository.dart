import 'package:sqflite/sqflite.dart';
import '../assets.dart'; // Mantido como assets.dart conforme seu arquivo
import '../suporte/database_helper.dart';

class AssetRepository {
  final DatabaseHelper _dbHelper;

  AssetRepository(this._dbHelper);

  Future<int> insert(Asset asset) async {
    final db = await _dbHelper.database;
    return await db.insert('Asset', asset.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Asset?> getById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db.query('Asset', where: 'id_asset = ?', whereArgs: [id]);
    if (maps.isNotEmpty) return Asset.fromMap(maps.first);
    return null;
  }

  Future<List<Asset>> getByUserId(int userId) async {
    final db = await _dbHelper.database;
    final maps = await db.query('Asset', where: 'user_id = ?', whereArgs: [userId]);
    return maps.map((map) => Asset.fromMap(map)).toList();
  }

  Future<int> update(Asset asset) async {
    final db = await _dbHelper.database;
    return await db.update('Asset', asset.toMap(), where: 'id_asset = ?', whereArgs: [asset.id]);
  }

  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('Asset', where: 'id_asset = ?', whereArgs: [id]);
  }
}