import 'enums.dart';

class Transaction {
  final int id;
  final int userId;
  final int categoryId; // Conexão direta com a categoria principal
  final int? subcategoryId;
  final String title; // Adicionado para suportar "Ex: Conta de Água"
  final double amount;
  final DateTime date;
  final TransactionType type;
  final TransactionTag tag; 
  final TransactionStatus status; // Adicionado para suportar Pago/Pendente

  const Transaction({
    required this.id,
    required this.userId,
    required this.categoryId,
    this.subcategoryId,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.tag,
    this.status = TransactionStatus.paid,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as int,
      userId: json['userId'] as int,
      categoryId: json['categoryId'] as int,
      subcategoryId: json['subcategoryId'] as int?,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      type: TransactionType.values.firstWhere((e) => e.name == json['type']),
      tag: TransactionTag.values.firstWhere((e) => e.name == json['tag']),
      status: TransactionStatus.values.firstWhere((e) => e.name == json['status'], orElse: () => TransactionStatus.paid),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'categoryId': categoryId,
      'subcategoryId': subcategoryId,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type.name,
      'tag': tag.name,
      'status': status.name,
    };
  }

  Transaction copyWith({
    int? id,
    int? userId,
    int? categoryId,
    int? subcategoryId,
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
      subcategoryId: subcategoryId ?? this.subcategoryId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
      tag: tag ?? this.tag,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          categoryId == other.categoryId &&
          subcategoryId == other.subcategoryId &&
          title == other.title &&
          amount == other.amount &&
          date == other.date &&
          type == other.type &&
          tag == other.tag &&
          status == other.status;

  @override
  int get hashCode =>
      id.hashCode ^ userId.hashCode ^ categoryId.hashCode ^ subcategoryId.hashCode ^ title.hashCode ^ amount.hashCode ^ date.hashCode ^ type.hashCode ^ tag.hashCode ^ status.hashCode;
}