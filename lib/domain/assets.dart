import 'enums.dart';

class Asset {
  final int id;
  final int userId;
  final String ticker; // Ex: BTC, USDT, PETR4.SA - SERÁ USADO NA API
  final String name; // Ex: Bitcoin, Petrobras SERÁ USADO NA INTERFACE
  final AssetClass assetClass;
  final bool isStaking;
  final double? currentPrice; // Cache do último preço retornado pela API
  final DateTime? lastPriceUpdate; 

  const Asset({
    required this.id,
    required this.userId,
    required this.ticker,
    required this.name,
    required this.assetClass,
    required this.isStaking,
    this.currentPrice,
    this.lastPriceUpdate,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'] as int,
      userId: json['userId'] as int,
      ticker: json['ticker'] as String,
      name: json['name'] as String,
      assetClass: AssetClass.values.firstWhere(
        (e) => e.name == json['assetClass'],
      ),
      isStaking: json['isStaking'] as bool,
      currentPrice: (json['currentPrice'] as num?)?.toDouble(),
      lastPriceUpdate: json['lastPriceUpdate'] != null ? DateTime.parse(json['lastPriceUpdate'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'ticker': ticker,
      'name': name,
      'assetClass': assetClass.name,
      'isStaking': isStaking,
      'currentPrice': currentPrice,
      'lastPriceUpdate': lastPriceUpdate?.toIso8601String(),
    };
  }

  

  Asset copyWith({
    int? id,
    int? userId,
    String? ticker,
    String? name,
    AssetClass? assetClass,
    bool? isStaking,
    double? currentPrice,
    DateTime? lastPriceUpdate,
  }) {
    return Asset(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      ticker: ticker ?? this.ticker,
      name: name ?? this.name,
      assetClass: assetClass ?? this.assetClass,
      isStaking: isStaking ?? this.isStaking,
      currentPrice: currentPrice ?? this.currentPrice,
      lastPriceUpdate: lastPriceUpdate ?? this.lastPriceUpdate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Asset &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          ticker == other.ticker &&
          name == other.name &&
          assetClass == other.assetClass &&
          isStaking == other.isStaking &&
          currentPrice == other.currentPrice &&
          lastPriceUpdate == other.lastPriceUpdate;

  @override
  int get hashCode =>
      id.hashCode ^ userId.hashCode ^ ticker.hashCode ^ name.hashCode ^ assetClass.hashCode ^ isStaking.hashCode ^ currentPrice.hashCode ^ lastPriceUpdate.hashCode;
}