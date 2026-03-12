import 'package:flutter_test/flutter_test.dart';
import 'package:invezzte/features/autenticacao/domain/models/category.dart';
import 'package:invezzte/features/autenticacao/domain/models/enums.dart';

void main() {
  group('Category', () {
    test('fromJson creates object correctly', () {
      final json = {
        'id': 1,
        'userId': 10,
        'name': 'Mobilidade',
        'type': 'expense',
      };

      final category = Category.fromJson(json);

      expect(category.id, 1);
      expect(category.userId, 10);
      expect(category.name, 'Mobilidade');
      expect(category.type, TransactionType.expense);
    });

    test('toJson produces correct JSON', () {
      final category = const Category(
        id: 1,
        userId: 10,
        name: 'Mobilidade',
        type: TransactionType.expense,
      );

      final json = category.toJson();

      expect(json['id'], 1);
      expect(json['userId'], 10);
      expect(json['name'], 'Mobilidade');
      expect(json['type'], 'expense');
    });

    test('copyWith modifies only specified fields', () {
      final category = const Category(
        id: 1,
        userId: 10,
        name: 'Mobilidade',
        type: TransactionType.expense,
      );

      final updatedCategory = category.copyWith(name: 'Transporte');

      expect(updatedCategory.id, 1);
      expect(updatedCategory.userId, 10);
      expect(updatedCategory.name, 'Transporte');
      expect(updatedCategory.type, TransactionType.expense);
    });
  });
}
