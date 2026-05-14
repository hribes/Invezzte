import 'package:flutter_test/flutter_test.dart';
import 'package:invezzte/domain/category.dart';

void main() {
  group('Category', () {
    test('fromJson creates object correctly', () {
      final json = {
        'id': 1,
        'userId': 10,
        'name': 'Mobilidade',
        'type': 'expense',
        'iconName': 'directions_car',
      };

      final category = Category.fromJson(json);

      expect(category.id, 1);
      expect(category.userId, 10);
      expect(category.name, 'Mobilidade');
    });

    test('fromJson creates correct Category object', () {
      final json = {
        'id': 1,
        'userId': 10,
        'name': 'Mobilidade',
        'type': 'expense',
        'iconName': 'directions_car',
      };

      final category = Category.fromJson(json);

      expect(category.id, 1);
      expect(category.userId, 10);
      expect(category.name, 'Mobilidade');
      expect(category.iconName, 'directions_car');
    });

    test('toJson produces correct JSON', () {
      final json = {
        'id': 1,
        'userId': 10,
        'name': 'Mobilidade',
        'iconName': 'shopping_cart',
      };

      final category = Category.fromJson(json);

      expect(category.id, 1);
      expect(category.userId, 10);
      expect(category.name, 'Mobilidade');
      expect(category.iconName, 'shopping_cart');
    });

    test('toJson produces correct JSON', () {
      final json = {
        'id': 1,
        'userId': 10,
        'name': 'Mobilidade',
        'iconName': 'shopping_cart',
      };

      final category = Category.fromJson(json);

      expect(category.id, 1);
      expect(category.userId, 10);
      expect(category.name, 'Mobilidade');
      expect(category.iconName, 'shopping_cart');
    });

    test('copyWith modifies only specified fields', () {
      final json = {
        'id': 1,
        'userId': 10,
        'name': 'Mobilidade',
        'iconName': 'shopping_cart',
      };

      final category = Category.fromJson(json);

      final updatedCategory = category.copyWith(name: 'Transporte');

      expect(updatedCategory.id, 1);
      expect(updatedCategory.userId, 10);
      expect(updatedCategory.name, 'Transporte');
    });
  });
}
