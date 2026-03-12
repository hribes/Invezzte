import 'package:invezzte/features/autenticacao/domain/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    test('fromJson creates object correctly', () {
      final json = {
        'id': 1,
        'name': 'Lucas',
        'email': 'lucashygidio123@gmail.com',
      };

      final user = User.fromJson(json);

      expect(user.id, 1);
      expect(user.name, 'Lucas');
      expect(user.email, 'lucashygidio123@gmail.com');
    });

    test('toJson produces correct JSON', () {
      final user = const User(
        id: 1,
        name: 'Lucas',
        email: 'lucashygidio123@gmail.com',
      );

      final json = user.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'Lucas');
      expect(json['email'], 'lucashygidio123@gmail.com');
    });

    test('copyWith modifies only specified fields', () {
      final user = const User(
        id: 1,
        name: 'Lucas',
        email: 'lucashygidio123@gmail.com',
      );

      final updatedUser = user.copyWith(name: 'Lucas Hygidio');

      expect(updatedUser.id, 1);
      expect(updatedUser.name, 'Lucas Hygidio');
      expect(updatedUser.email, 'lucashygidio123@gmail.com');
    });
  });
}
