import 'enums.dart';

class User {
  final int id;
  final String? name;
  final String? email;
  final double? balance;
  final double? patrimony;
  final Gender? gender;
  final String? password;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.balance = 0.0,
    this.patrimony = 0.0,
    this.gender,
    this.password,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id_user'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      balance: (map['saldo'] as num?)?.toDouble() ?? 0.0,
      gender: map['gender'] != null
          ? Gender.values.firstWhere(
              (e) => e.name == map['gender'],
              orElse: () => Gender.preferNotToSay,
            )
          : null,
      patrimony: (map['patrimony'] as num?)?.toDouble() ?? 0.0,
      password: map['password'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_user': id,
      'name': name,
      'email': email,
      'gender': gender?.name,
      'saldo': balance,
      'patrimony': patrimony,
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
      balance: saldo ?? this.balance,
      gender: gender ?? this.gender,
      patrimony: patrimony ?? this.patrimony,
      password: password ?? this.password,
    );
  }
}
