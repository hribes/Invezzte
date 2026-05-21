import 'package:flutter/material.dart';

class Category {
  final int id;
  final int userId;
  final String name;
  final String iconName; 
  final String? colorHex; // Adicionado para suportar as cores do gráfico e UI

  const Category({
    required this.id,
    required this.userId,
    required this.name,
    required this.iconName, 
    this.colorHex,
  });

  IconData get icon => _getIconFromName(iconName);

  Color get color => colorHex != null 
      ? Color(int.parse(colorHex!.replaceAll('#', '0xff'))) 
      : Colors.grey;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      userId: json['userId'] as int,
      name: json['name'] as String,
      iconName: json['iconName'] as String? ?? 'help_outline', 
      colorHex: json['colorHex'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'iconName': iconName,
      'colorHex': colorHex,
    };
  }

  Category copyWith({
    int? id,
    int? userId,
    String? name,
    String? iconName,
    String? colorHex,
  }) {
    return Category(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
    );
  }

  static IconData _getIconFromName(String name) {
    switch (name) {
      case 'shopping_cart': return Icons.shopping_cart;
      case 'restaurant': return Icons.restaurant;
      case 'directions_car': return Icons.directions_car;
      case 'home': return Icons.home;
      case 'credit_card': return Icons.credit_card;
      default: return Icons.help_outline;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          name == other.name &&
          iconName == other.iconName &&
          colorHex == other.colorHex;

  @override
  int get hashCode =>
      id.hashCode ^ userId.hashCode ^ name.hashCode ^ iconName.hashCode ^ colorHex.hashCode;
}