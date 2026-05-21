import 'enums.dart';

class User {
  final int id;
  final String name;
  final String email;
  final double saldo;
  final Gender? gender;
  final double? salaryAmount;
  final SalaryFrequency? salaryFrequency;
  final DateTime? salaryDate;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.saldo = 0.0,
    this.gender,
    this.salaryAmount,
    this.salaryFrequency,
    this.salaryDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      saldo: (json['saldo'] as num?)?.toDouble() ?? 0.0,
      gender: json['gender'] != null 
          ? Gender.values.firstWhere((e) => e.name == json['gender'], orElse: () => Gender.preferNotToSay) 
          : null,
      salaryAmount: (json['salaryAmount'] as num?)?.toDouble(),
      salaryFrequency: json['salaryFrequency'] != null 
          ? SalaryFrequency.values.firstWhere((e) => e.name == json['salaryFrequency'], orElse: () => SalaryFrequency.monthly) 
          : null,
      salaryDate: json['salaryDate'] != null ? DateTime.parse(json['salaryDate'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 
      'name': name, 
      'email': email, 
      'saldo': saldo,
      'gender': gender?.name,
      'salaryAmount': salaryAmount,
      'salaryFrequency': salaryFrequency?.name,
      'salaryDate': salaryDate?.toIso8601String(),
    };
  }

  User copyWith({
    int? id, 
    String? name, 
    String? email, 
    double? saldo,
    Gender? gender,
    double? salaryAmount,
    SalaryFrequency? salaryFrequency,
    DateTime? salaryDate,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      saldo: saldo ?? this.saldo,
      gender: gender ?? this.gender,
      salaryAmount: salaryAmount ?? this.salaryAmount,
      salaryFrequency: salaryFrequency ?? this.salaryFrequency,
      salaryDate: salaryDate ?? this.salaryDate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          saldo == other.saldo &&
          gender == other.gender &&
          salaryAmount == other.salaryAmount &&
          salaryFrequency == other.salaryFrequency &&
          salaryDate == other.salaryDate;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ email.hashCode ^ saldo.hashCode ^ gender.hashCode ^ salaryAmount.hashCode ^ salaryFrequency.hashCode ^ salaryDate.hashCode;
}