import 'package:sqflite/sqflite.dart';
import '../category.dart';
import '../suporte/database_helper.dart';

class CategoryRepository {
  final DatabaseHelper _dbHelper;

  CategoryRepository(this._dbHelper);

  Future<int> insert(Category category) async {
    final db = await _dbHelper.database;
    return await db.insert('Category', category.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Category?> getById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db.query('Category', where: 'id_category = ?', whereArgs: [id]);
    if (maps.isNotEmpty) return Category.fromMap(maps.first);
    return null;
  }

  Future<List<Category>> getByUserId(int userId) async {
    final db = await _dbHelper.database;
    final maps = await db.query('Category', where: 'user_id = ?', whereArgs: [userId]);
    return maps.map((map) => Category.fromMap(map)).toList();
  }

  Future<int> update(Category category) async {
    final db = await _dbHelper.database;
    return await db.update('Category', category.toMap(), where: 'id_category = ?', whereArgs: [category.id]);
  }

  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('Category', where: 'id_category = ?', whereArgs: [id]);
  }
}