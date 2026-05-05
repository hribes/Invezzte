class Subcategory {
  final int id;
  final int categoryId;
  final String name;

  const Subcategory({
    required this.id,
    required this.categoryId,
    required this.name,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['id'] as int,
      categoryId: json['categoryId'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'categoryId': categoryId, 'name': name};
  }

  Subcategory copyWith({int? id, int? categoryId, String? name}) {
    return Subcategory(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Subcategory &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          categoryId == other.categoryId &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ categoryId.hashCode ^ name.hashCode;
}
