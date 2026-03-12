import 'enums.dart';

class Asset {
  final int id;
  final int userId;
  final String tickerOrName;
  final AssetClass assetClass;
  final bool isStaking;

  const Asset({
    required this.id,
    required this.userId,
    required this.tickerOrName,
    required this.assetClass,
    required this.isStaking,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'] as int,
      userId: json['userId'] as int,
      tickerOrName: json['tickerOrName'] as String,
      assetClass: AssetClass.values.firstWhere(
        (e) => e.name == json['assetClass'],
      ),
      isStaking: json['isStaking'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'tickerOrName': tickerOrName,
      'assetClass': assetClass.name,
      'isStaking': isStaking,
    };
  }

  Asset copyWith({
    int? id,
    int? userId,
    String? tickerOrName,
    AssetClass? assetClass,
    bool? isStaking,
  }) {
    return Asset(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tickerOrName: tickerOrName ?? this.tickerOrName,
      assetClass: assetClass ?? this.assetClass,
      isStaking: isStaking ?? this.isStaking,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Asset &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          tickerOrName == other.tickerOrName &&
          assetClass == other.assetClass &&
          isStaking == other.isStaking;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      tickerOrName.hashCode ^
      assetClass.hashCode ^
      isStaking.hashCode;
}
