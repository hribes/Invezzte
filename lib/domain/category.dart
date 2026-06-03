import 'package:flutter/material.dart';

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

  IconData get icon => _getIconFromName(iconName);

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id_category'] as int,
      userId: map['user_id'] as int,
      name: map['name'] as String,
      iconName: map['icon_name'] as String? ?? 'help_outline',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_category': id,
      'user_id': userId,
      'name': name,
      'icon_name': iconName,
    };
  }

  Category copyWith({int? id, int? userId, String? name, String? iconName}) {
    return Category(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
    );
  }

  static IconData _getIconFromName(String name) {
    switch (name) {
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'restaurant':
        return Icons.restaurant;
      case 'directions_car':
        return Icons.directions_car;
      case 'home':
        return Icons.home;
      case 'credit_card':
        return Icons.credit_card;
      case 'school':
        return Icons.school;
      case 'work':
        return Icons.work;
      case 'pet':
        return Icons.pets;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'plane':
        return Icons.airplanemode_active;
      case 'entertainment':
        return Icons.movie;
      default:
        return Icons.help_outline;
    }
  }
}
