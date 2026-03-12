import 'package:flutter_test/flutter_test.dart';
import 'package:invezzte/features/autenticacao/domain/models/enums.dart';
import 'package:invezzte/features/autenticacao/domain/models/investment_operation.dart';

void main() {
  group('InvestmentOperation', () {
    test('fromJson creates object correctly', () {
      final json = {
        'id': 1,
        'assetId': 42,
        'operationType': 'buy',
        'totalAmount': 5000.0,
        'quantity': 0.05,
        'date': '2026-03-12T14:30:00.000',
      };

      final operation = InvestmentOperation.fromJson(json);

      expect(operation.id, 1);
      expect(operation.assetId, 42);
      expect(operation.operationType, OperationType.buy);
      expect(operation.totalAmount, 5000.0);
      expect(operation.quantity, 0.05);
      expect(operation.date, DateTime(2026, 3, 12, 14, 30, 0));
    });

    test('toJson produces correct JSON', () {
      final operation = InvestmentOperation(
        id: 1,
        assetId: 42,
        operationType: OperationType.buy,
        totalAmount: 5000.0,
        quantity: 0.05,
        date: DateTime(2026, 3, 12, 14, 30, 0),
      );

      final json = operation.toJson();

      expect(json['id'], 1);
      expect(json['assetId'], 42);
      expect(json['operationType'], 'buy');
      expect(json['totalAmount'], 5000.0);
      expect(json['quantity'], 0.05);
      expect(json['date'], '2026-03-12T14:30:00.000');
    });

    test('copyWith modifies only specified fields', () {
      final operation = InvestmentOperation(
        id: 1,
        assetId: 42,
        operationType: OperationType.buy,
        totalAmount: 5000.0,
        quantity: 0.05,
        date: DateTime(2026, 3, 12, 14, 30, 0),
      );

      final updatedOperation = operation.copyWith(
        totalAmount: 5500.0,
        quantity: 0.055,
      );

      expect(updatedOperation.id, 1);
      expect(updatedOperation.assetId, 42);
      expect(updatedOperation.operationType, OperationType.buy);
      expect(updatedOperation.totalAmount, 5500.0);
      expect(updatedOperation.quantity, 0.055);
      expect(updatedOperation.date, DateTime(2026, 3, 12, 14, 30, 0));
    });
  });
}
