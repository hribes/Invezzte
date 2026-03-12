class RecurringExpense {
  final int id;
  final int userId;
  final int subcategoryId;
  final double expectedAmount;
  final int dueDate;
  final bool isActive;

  const RecurringExpense({
    required this.id,
    required this.userId,
    required this.subcategoryId,
    required this.expectedAmount,
    required this.dueDate,
    required this.isActive,
  });

  factory RecurringExpense.fromJson(Map<String, dynamic> json) {
    return RecurringExpense(
      id: json['id'] as int,
      userId: json['userId'] as int,
      subcategoryId: json['subcategoryId'] as int,
      expectedAmount: (json['expectedAmount'] as num).toDouble(),
      dueDate: json['dueDate'] as int,
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'subcategoryId': subcategoryId,
      'expectedAmount': expectedAmount,
      'dueDate': dueDate,
      'isActive': isActive,
    };
  }

  RecurringExpense copyWith({
    int? id,
    int? userId,
    int? subcategoryId,
    double? expectedAmount,
    int? dueDate,
    bool? isActive,
  }) {
    return RecurringExpense(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      expectedAmount: expectedAmount ?? this.expectedAmount,
      dueDate: dueDate ?? this.dueDate,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurringExpense &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          subcategoryId == other.subcategoryId &&
          expectedAmount == other.expectedAmount &&
          dueDate == other.dueDate &&
          isActive == other.isActive;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      subcategoryId.hashCode ^
      expectedAmount.hashCode ^
      dueDate.hashCode ^
      isActive.hashCode;
}
