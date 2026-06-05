import 'package:flutter/foundation.dart';
import 'package:invezzte/core/injecao.dart';
import 'package:invezzte/domain/repositories/saldo_repository.dart';
import 'package:invezzte/domain/user.dart';
import 'package:invezzte/domain/notifiers/user_notifier.dart'; // Importe o seu UserProvider

class SaldoNotifier extends ChangeNotifier {
  bool _carregando = false;

  bool get carregando => _carregando;

  User? get usuario => sl<UserProvider>().currentUser;
  double get saldo => sl<UserProvider>().currentUser?.balance ?? 0.0;

 Future<void> carregarSaldo() async {
    _carregando = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300)); 
    
    _carregando = false;
    notifyListeners();
  }

  Future<void> adicionarSaldo(double valor) async {
    final repository = sl<SaldoRepository>();
    await repository.salvarSaldo(valor);

    final saldoAtual = sl<UserProvider>().currentUser?.balance ?? 0.0;
    sl<UserProvider>().atualizarSaldo(saldoAtual + valor);

    notifyListeners(); 
  }

Future<void> retirarSaldo(double valor) async {
    final repository = sl<SaldoRepository>();
    await repository.salvarSaldo(-valor); 

    final saldoAtual = sl<UserProvider>().currentUser?.balance ?? 0.0;
    
    sl<UserProvider>().atualizarSaldo(saldoAtual - valor);
    
    notifyListeners(); 
  }
}