import 'package:flutter_test/flutter_test.dart';
import 'package:invezzte/features/autenticacao/domain/models/recurring_expense.dart';

void main() {
  group('RecurringExpense', () {
    test('fromJson creates object correctly', () {
      final json = {
        'id': 1,
        'userId': 10,
        'subcategoryId': 3,
        'expectedAmount': 120.0,
        'dueDate': 5,
        'isActive': true,
      };

      final expense = RecurringExpense.fromJson(json);

      expect(expense.id, 1);
      expect(expense.userId, 10);
      expect(expense.subcategoryId, 3);
      expect(expense.expectedAmount, 120.0);
      expect(expense.dueDate, 5);
      expect(expense.isActive, true);
    });

    test('toJson produces correct JSON', () {
      final expense = const RecurringExpense(
        id: 1,
        userId: 10,
        subcategoryId: 3,
        expectedAmount: 120.0,
        dueDate: 5,
        isActive: true,
      );

      final json = expense.toJson();

      expect(json['id'], 1);
      expect(json['userId'], 10);
      expect(json['subcategoryId'], 3);
      expect(json['expectedAmount'], 120.0);
      expect(json['dueDate'], 5);
      expect(json['isActive'], true);
    });

    test('copyWith modifies only specified fields', () {
      final expense = const RecurringExpense(
        id: 1,
        userId: 10,
        subcategoryId: 3,
        expectedAmount: 120.0,
        dueDate: 5,
        isActive: true,
      );

      final updatedExpense = expense.copyWith(
        expectedAmount: 135.50,
        isActive: false,
      );

      expect(updatedExpense.id, 1);
      expect(updatedExpense.userId, 10);
      expect(updatedExpense.subcategoryId, 3);
      expect(updatedExpense.expectedAmount, 135.50);
      expect(updatedExpense.dueDate, 5);
      expect(updatedExpense.isActive, false);
    });
  });
}
