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
  final String? password;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.saldo = 0.0,
    this.gender,
    this.salaryAmount,
    this.salaryFrequency,
    this.salaryDate,
    this.password,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id_user'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      saldo: (map['saldo'] as num?)?.toDouble() ?? 0.0,
      gender: map['gender'] != null 
          ? Gender.values.firstWhere((e) => e.name == map['gender'], orElse: () => Gender.preferNotToSay) 
          : null,
      salaryAmount: (map['salary_amount'] as num?)?.toDouble(),
      salaryFrequency: map['salary_frequency'] != null 
          ? SalaryFrequency.values.firstWhere((e) => e.name == map['salary_frequency'], orElse: () => SalaryFrequency.monthly) 
          : null,
      salaryDate: map['salary_date'] != null ? DateTime.parse(map['salary_date'] as String) : null,
      password: map['password'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_user': id, 
      'name': name, 
      'email': email, 
      'gender': gender?.name,
      'saldo': saldo,
      'salary_amount': salaryAmount,
      'salary_frequency': salaryFrequency?.name,
      'salary_date': salaryDate?.toIso8601String(),
      'password': password,
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
    String? password,
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
      password: password ?? this.password,
    );
  }
}