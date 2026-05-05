import 'enums.dart';

class Transaction {
  final int id;
  final int userId;
  final int? subcategoryId;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final TransactionTag tag;

  const Transaction({
    required this.id,
    required this.userId,
    this.subcategoryId,
    required this.amount,
    required this.date,
    required this.type,
    required this.tag,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as int,
      userId: json['userId'] as int,
      subcategoryId: json['subcategoryId'] as int?,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      type: TransactionType.values.firstWhere((e) => e.name == json['type']),
      tag: TransactionTag.values.firstWhere((e) => e.name == json['tag']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'subcategoryId': subcategoryId,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type.name,
      'tag': tag.name,
    };
  }

  Transaction copyWith({
    int? id,
    int? userId,
    int? subcategoryId,
    double? amount,
    DateTime? date,
    TransactionType? type,
    TransactionTag? tag,
  }) {
    return Transaction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
      tag: tag ?? this.tag,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          subcategoryId == other.subcategoryId &&
          amount == other.amount &&
          date == other.date &&
          type == other.type &&
          tag == other.tag;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      subcategoryId.hashCode ^
      amount.hashCode ^
      date.hashCode ^
      type.hashCode ^
      tag.hashCode;
}
