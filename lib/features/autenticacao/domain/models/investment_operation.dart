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

  factory InvestmentOperation.fromJson(Map<String, dynamic> json) {
    return InvestmentOperation(
      id: json['id'] as int,
      assetId: json['assetId'] as int,
      operationType: OperationType.values.firstWhere(
        (e) => e.name == json['operationType'],
      ),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assetId': assetId,
      'operationType': operationType.name,
      'totalAmount': totalAmount,
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvestmentOperation &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          assetId == other.assetId &&
          operationType == other.operationType &&
          totalAmount == other.totalAmount &&
          quantity == other.quantity &&
          date == other.date;

  @override
  int get hashCode =>
      id.hashCode ^
      assetId.hashCode ^
      operationType.hashCode ^
      totalAmount.hashCode ^
      quantity.hashCode ^
      date.hashCode;
}
