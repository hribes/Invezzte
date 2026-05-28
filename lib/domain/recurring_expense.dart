class RecurringExpense {
  final int id;
  final int userId;
  final double expectedAmount;
  final int categoryId;

  const RecurringExpense({
    required this.id,
    required this.userId,
    required this.expectedAmount,
    required this.categoryId,
  });

  factory RecurringExpense.fromMap(Map<String, dynamic> map) {
    return RecurringExpense(
      id: map['id_recurring'] as int,
      userId: map['user_id'] as int,
      expectedAmount: (map['expected_amount'] as num).toDouble(),
      categoryId: map['category_id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_recurring': id,
      'user_id': userId,
      'expected_amount': expectedAmount,
      'category_id': categoryId,
    };
  }

  RecurringExpense copyWith({
    int? id,
    int? userId,
    double? expectedAmount,
    int? categoryId,
  }) {
    return RecurringExpense(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      expectedAmount: expectedAmount ?? this.expectedAmount,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}