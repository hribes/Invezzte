import 'enums.dart';

class Transaction {
  final int id;
  final int userId;
  final int categoryId;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;

  const Transaction({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id_transaction'] as int,
      userId: map['user_id'] as int,
      categoryId: map['category_id'] as int,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.parse(map['date'] as String),
      type: TransactionType.values.firstWhere((e) => e.name == map['type']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_transaction': id,
      'user_id': userId,
      'category_id': categoryId,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type.name,
    };
  }

  Transaction copyWith({
    int? id,
    int? userId,
    int? categoryId,
    String? title,
    double? amount,
    DateTime? date,
    TransactionType? type,
    TransactionTag? tag,
    TransactionStatus? status,
  }) {
    return Transaction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
    );
  }
}
