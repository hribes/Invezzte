class Asset {
  final int id;
  final int userId;
  final String ticker;
  final String name;
  final bool isStaking;
  final double? currentPrice;
  final DateTime? lastPriceUpdate;

  const Asset({
    required this.id,
    required this.userId,
    required this.ticker,
    required this.name,
    required this.isStaking,
    this.currentPrice,
    this.lastPriceUpdate,
  });

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      id: map['id_asset'] as int,
      userId: map['user_id'] as int,
      ticker: map['ticker'] as String,
      name: map['name'] as String,
      isStaking: (map['is_staking'] as int) == 1,
      currentPrice: (map['current_price'] as num?)?.toDouble(),
      lastPriceUpdate: map['last_price_update'] != null
          ? DateTime.parse(map['last_price_update'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_asset': id,
      'user_id': userId,
      'ticker': ticker,
      'name': name,
      'is_staking': isStaking ? 1 : 0, // SQLite boolean
      'current_price': currentPrice,
      'last_price_update': lastPriceUpdate?.toIso8601String(),
    };
  }

  Asset copyWith({
    int? id,
    int? userId,
    String? ticker,
    String? name,
    bool? isStaking,
    double? currentPrice,
    DateTime? lastPriceUpdate,
  }) {
    return Asset(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      ticker: ticker ?? this.ticker,
      name: name ?? this.name,
      isStaking: isStaking ?? this.isStaking,
      currentPrice: currentPrice ?? this.currentPrice,
      lastPriceUpdate: lastPriceUpdate ?? this.lastPriceUpdate,
    );
  }
}
