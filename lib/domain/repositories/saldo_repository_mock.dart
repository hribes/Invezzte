import 'package:invezzte/domain/repositories/saldo_repository.dart';

class SaldoRepositoryMock implements SaldoRepository {
  double _saldo = 10.65;

  @override
  Future<double> buscarSaldo() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _saldo;
  }

  @override
  Future<void> salvarSaldo(double valor) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _saldo = _saldo + valor;
  }
}
