import 'package:flutter/material.dart';
import 'enums.dart';



class Category {
  final int id;
  final int userId;
  final String name;
  final String iconName; 

  const Category({
    required this.id,
    required this.userId,
    required this.name,
    required this.iconName, 
  });

  // Recupera o ícone baseado no nome
  IconData get icon => _getIconFromName(iconName);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      userId: json['userId'] as int,
      name: json['name'] as String,
      iconName: json['iconName'] as String? ?? 'help_outline', 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'iconName': iconName,
    };
  }

  Category copyWith({
    int? id,
    int? userId,
    String? name,
    TransactionType? type,
    String? iconName,
  }) {
    return Category(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
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
          iconName == other.iconName;

  @override
  int get hashCode =>
      id.hashCode ^ userId.hashCode ^ name.hashCode  ^ iconName.hashCode;
}