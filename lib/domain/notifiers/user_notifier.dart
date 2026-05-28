import 'package:flutter/material.dart';
import 'package:invezzte/domain/user.dart'; 
import 'package:invezzte/domain/enums.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser;


  User? get currentUser => _currentUser;

  bool get isLogged => _currentUser != null;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = User(
      id: 1,
      name: "Lorena", 
      email: email,
      saldo: 15400.50,
      gender: Gender.preferNotToSay, 
    );


    notifyListeners();
    
    return true; 
  }

  void logout() {
    _currentUser = null; 
    notifyListeners();
  }

  void atualizarSaldo(double novoSaldo) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(saldo: novoSaldo);
      notifyListeners(); 
    }
  }
}