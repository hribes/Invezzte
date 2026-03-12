import 'package:flutter_test/flutter_test.dart';
import 'package:invezzte/features/autenticacao/domain/models/subcategory.dart';

void main() {
  group('Subcategory', () {
    test('fromJson creates object correctly', () {
      final json = {'id': 1, 'categoryId': 5, 'name': 'Uber'};

      final subcategory = Subcategory.fromJson(json);

      expect(subcategory.id, 1);
      expect(subcategory.categoryId, 5);
      expect(subcategory.name, 'Uber');
    });

    test('toJson produces correct JSON', () {
      final subcategory = const Subcategory(id: 1, categoryId: 5, name: 'Uber');

      final json = subcategory.toJson();

      expect(json['id'], 1);
      expect(json['categoryId'], 5);
      expect(json['name'], 'Uber');
    });

    test('copyWith modifies only specified fields', () {
      final subcategory = const Subcategory(id: 1, categoryId: 5, name: 'Uber');

      final updatedSubcategory = subcategory.copyWith(name: 'Gasolina');

      expect(updatedSubcategory.id, 1);
      expect(updatedSubcategory.categoryId, 5);
      expect(updatedSubcategory.name, 'Gasolina');
    });
  });
}
