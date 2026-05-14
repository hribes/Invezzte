import 'package:flutter/foundation.dart';
import 'package:invezzte/core/injecao.dart';
import 'package:invezzte/domain/repositories/saldo_repository.dart';
import 'package:invezzte/domain/user.dart';

class SaldoNotifier extends ChangeNotifier {
  User _usuario = const User(
    id: 1,
    name: "Lucas Hygidio",
    email: "lucas@email.com",
    saldo: 0.0,
  );

  bool _carregando = false;

  User get usuario => _usuario;
  double get saldo => _usuario.saldo;
  bool get carregando => _carregando;

  Future<void> carregarSaldo() async {
    _carregando = true;
    notifyListeners();

    final repository = sl<SaldoRepository>();
    final saldoBuscado = await repository.buscarSaldo();

    _usuario = _usuario.copyWith(saldo: saldoBuscado);
    _carregando = false;
    notifyListeners();
  }

  Future<void> adicionarSaldo(double valor) async {
    final repository = sl<SaldoRepository>();
    await repository.salvarSaldo(valor);

    _usuario = _usuario.copyWith(saldo: _usuario.saldo + valor);
    notifyListeners();
  }
}
