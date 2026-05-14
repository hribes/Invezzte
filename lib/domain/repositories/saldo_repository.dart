abstract class SaldoRepository {
  Future<double> buscarSaldo();
  Future<void> salvarSaldo(double valor);
}
