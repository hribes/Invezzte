class User {
  final int id;
  final String name;
  final String email;
  final double saldo;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.saldo = 0.0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      saldo: (json['saldo'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'saldo': saldo};
  }

  User copyWith({int? id, String? name, String? email, double? saldo}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      saldo: saldo ?? this.saldo,
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
          saldo == other.saldo;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ email.hashCode ^ saldo.hashCode;
}
