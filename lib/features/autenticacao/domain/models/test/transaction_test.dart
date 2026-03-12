import 'package:flutter_test/flutter_test.dart';
import 'package:invezzte/features/autenticacao/domain/models/enums.dart';
import 'package:invezzte/features/autenticacao/domain/models/transaction.dart';

void main() {
  group('Transaction', () {
    test('fromJson creates object correctly', () {
      final json = {
        'id': 1,
        'userId': 10,
        'subcategoryId': 5,
        'amount': 150.50,
        'date': '2026-03-12T10:00:00.000',
        'type': 'expense',
        'tag': 'variable',
      };

      final transaction = Transaction.fromJson(json);

      expect(transaction.id, 1);
      expect(transaction.userId, 10);
      expect(transaction.subcategoryId, 5);
      expect(transaction.amount, 150.50);
      expect(transaction.date, DateTime(2026, 3, 12, 10, 0, 0));
      expect(transaction.type, TransactionType.expense);
      expect(transaction.tag, TransactionTag.variable);
    });

    test('toJson produces correct JSON', () {
      final transaction = Transaction(
        id: 1,
        userId: 10,
        subcategoryId: 5,
        amount: 150.50,
        date: DateTime(2026, 3, 12, 10, 0, 0),
        type: TransactionType.expense,
        tag: TransactionTag.variable,
      );

      final json = transaction.toJson();

      expect(json['id'], 1);
      expect(json['userId'], 10);
      expect(json['subcategoryId'], 5);
      expect(json['amount'], 150.50);
      expect(json['date'], '2026-03-12T10:00:00.000');
      expect(json['type'], 'expense');
      expect(json['tag'], 'variable');
    });

    test('copyWith modifies only specified fields', () {
      final transaction = Transaction(
        id: 1,
        userId: 10,
        subcategoryId: 5,
        amount: 150.50,
        date: DateTime(2026, 3, 12, 10, 0, 0),
        type: TransactionType.expense,
        tag: TransactionTag.variable,
      );

      final updatedTransaction = transaction.copyWith(amount: 200.00);

      expect(updatedTransaction.id, 1);
      expect(updatedTransaction.userId, 10);
      expect(updatedTransaction.subcategoryId, 5);
      expect(updatedTransaction.amount, 200.00);
      expect(updatedTransaction.date, DateTime(2026, 3, 12, 10, 0, 0));
      expect(updatedTransaction.type, TransactionType.expense);
      expect(updatedTransaction.tag, TransactionTag.variable);
    });
  });
}
