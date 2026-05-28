import 'enums.dart';

class InvestmentOperation {
  final int id;
  final int assetId;
  final OperationType operationType;
  final double totalAmount;
  final double quantity;
  final DateTime date;

  const InvestmentOperation({
    required this.id,
    required this.assetId,
    required this.operationType,
    required this.totalAmount,
    required this.quantity,
    required this.date,
  });

  factory InvestmentOperation.fromMap(Map<String, dynamic> map) {
    return InvestmentOperation(
      id: map['id_investment'] as int,
      assetId: map['asset_id'] as int,
      operationType: OperationType.values.firstWhere(
        (e) => e.name == map['operation_type'],
      ),
      totalAmount: (map['total_amount'] as num).toDouble(),
      quantity: (map['quantity'] as num).toDouble(),
      date: DateTime.parse(map['date'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_investment': id,
      'asset_id': assetId,
      'operation_type': operationType.name,
      'total_amount': totalAmount,
      'quantity': quantity,
      'date': date.toIso8601String(),
    };
  }

  InvestmentOperation copyWith({
    int? id,
    int? assetId,
    OperationType? operationType,
    double? totalAmount,
    double? quantity,
    DateTime? date,
  }) {
    return InvestmentOperation(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      operationType: operationType ?? this.operationType,
      totalAmount: totalAmount ?? this.totalAmount,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
    );
  }
}