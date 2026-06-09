import 'package:flutter/material.dart';

class PatrimonioHistoryNotifier extends ChangeNotifier {
  List<double> _patrimonioHistory = [];
  
  List<double> get patrimonioHistory => _patrimonioHistory;
  
  void adicionarRegistro(double valor) {
    _patrimonioHistory.add(valor);
    notifyListeners();
  }
  
  void limparHistorico() {
    _patrimonioHistory.clear();
    notifyListeners();
  }
  
  List<double> obterUltimos(int quantidade) {
    if (_patrimonioHistory.isEmpty) return [];
    final inicio = (_patrimonioHistory.length - quantidade).clamp(0, _patrimonioHistory.length);
    return _patrimonioHistory.sublist(inicio);
  }
}
