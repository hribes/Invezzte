import 'package:sqflite/sqflite.dart';
import '../recurring_expense.dart';
import '../suporte/database_helper.dart';

class RecurringExpenseRepository {
  final DatabaseHelper _dbHelper;

  RecurringExpenseRepository(this._dbHelper);

  Future<int> insert(RecurringExpense expense) async {
    final db = await _dbHelper.database;
    return await db.insert('Recurring_Expense', expense.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<RecurringExpense>> getByUserId(int userId) async {
    final db = await _dbHelper.database;
    final maps = await db.query('Recurring_Expense', where: 'user_id = ?', whereArgs: [userId]);
    return maps.map((map) => RecurringExpense.fromMap(map)).toList();
  }

  Future<int> update(RecurringExpense expense) async {
    final db = await _dbHelper.database;
    return await db.update('Recurring_Expense', expense.toMap(), where: 'id_recurring = ?', whereArgs: [expense.id]);
  }

  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('Recurring_Expense', where: 'id_recurring = ?', whereArgs: [id]);
  }
}