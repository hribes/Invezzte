import 'package:sqflite/sqflite.dart';
import '../investment_operation.dart';
import '../suporte/database_helper.dart';

class InvestmentOperationRepository {
  final DatabaseHelper _dbHelper;

  InvestmentOperationRepository(this._dbHelper);

  Future<int> insert(InvestmentOperation operation) async {
    final db = await _dbHelper.database;
    return await db.insert('Investment_Operation', operation.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<InvestmentOperation>> getByAssetId(int assetId) async {
    final db = await _dbHelper.database;
    final maps = await db.query('Investment_Operation', where: 'asset_id = ?', whereArgs: [assetId]);
    return maps.map((map) => InvestmentOperation.fromMap(map)).toList();
  }

  Future<int> update(InvestmentOperation operation) async {
    final db = await _dbHelper.database;
    return await db.update('Investment_Operation', operation.toMap(), where: 'id_investment = ?', whereArgs: [operation.id]);
  }

  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('Investment_Operation', where: 'id_investment = ?', whereArgs: [id]);
  }
}