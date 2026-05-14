import 'package:flutter/foundation.dart';
import 'package:invezzte/domain/user.dart';

class SaldoNotifier extends ChangeNotifier {
  User _usuario = const User(
    id: 1,
    name: "Lucas Hygidio",
    email: "lucas@email.com",
    saldo: 4569.65,
  );

  User get usuario => _usuario;
  double get saldo => _usuario.saldo;

  void adicionarSaldo(double valor) {
    _usuario = _usuario.copyWith(saldo: _usuario.saldo + valor);
    notifyListeners();
  }
}
