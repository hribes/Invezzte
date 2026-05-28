import 'package:sqflite/sqflite.dart' hide Transaction; //O sqlite tem uma classe que chama transaction, então estava dando conflito, por isso o hide
import 'package:invezzte/domain/transaction.dart';
import '../suporte/database_helper.dart';

class TransactionRepository {
  final DatabaseHelper _dbHelper;

  TransactionRepository(this._dbHelper);

  Future<int> insert(Transaction transaction) async {
    final db = await _dbHelper.database;
    return await db.insert('"Transaction"', transaction.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Transaction>> getByUserId(int userId) async {
    final db = await _dbHelper.database;
    final maps = await db.query('"Transaction"', where: 'user_id = ?', whereArgs: [userId]);
    return maps.map((map) => Transaction.fromMap(map)).toList();
  }

  Future<List<Transaction>> getByDateRange(int userId, String startDate, String endDate) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      '"Transaction"', 
      where: 'user_id = ? AND date BETWEEN ? AND ?', 
      whereArgs: [userId, startDate, endDate]
    );
    return maps.map((map) => Transaction.fromMap(map)).toList();
  }

  Future<int> update(Transaction transaction) async {
    final db = await _dbHelper.database;
    return await db.update('"Transaction"', transaction.toMap(), where: 'id_transaction = ?', whereArgs: [transaction.id]);
  }

  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('"Transaction"', where: 'id_transaction = ?', whereArgs: [id]);
  }
}