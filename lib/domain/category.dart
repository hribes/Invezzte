import 'enums.dart';

class Category {
  final int id;
  final int userId;
  final String name;
  final TransactionType type;

  const Category({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      userId: json['userId'] as int,
      name: json['name'] as String,
      type: TransactionType.values.firstWhere((e) => e.name == json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'userId': userId, 'name': name, 'type': type.name};
  }

  Category copyWith({
    int? id,
    int? userId,
    String? name,
    TransactionType? type,
  }) {
    return Category(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          name == other.name &&
          type == other.type;

  @override
  int get hashCode =>
      id.hashCode ^ userId.hashCode ^ name.hashCode ^ type.hashCode;
}
