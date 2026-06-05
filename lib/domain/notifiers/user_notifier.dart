import 'package:flutter/material.dart';
import 'package:invezzte/domain/user.dart'; 
import 'package:invezzte/core/injecao.dart'; 
import 'package:invezzte/domain/repositories/user_repository.dart';
import 'package:invezzte/domain/category.dart';
import 'package:invezzte/domain/repositories/category_repository.dart';
import 'package:invezzte/domain/enums.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isLogged => _currentUser != null;

  Future<bool> login(String email, String password) async {
    final userRepository = sl<UserRepository>();
    
    final user = await userRepository.getByCredentials(email, password);

    if (user != null) {
      _currentUser = user; 
      notifyListeners();
      return true; 
    }

    return false; 
  }

  Future<bool> cadastrar(String nome, String email, String password) async {
    final userRepository = sl<UserRepository>();
    
    final idGerado = DateTime.now().millisecondsSinceEpoch;

    final novoUsuario = User(
      id: idGerado,
      name: nome,
      email: email,
      password: password,
      balance: 0.0,
      patrimony: 0.0,
      gender: Gender.preferNotToSay,
    );

    await userRepository.insert(novoUsuario);

    final sucessoLogin = await login(email, password);

    if (sucessoLogin && _currentUser != null) {
      final categoryRepo = sl<CategoryRepository>();
      final userId = _currentUser!.id;

      final categoriasPadrao = [
        Category(id: idGerado + 1, userId: userId, name: "Casa", iconName: 'home'),
        Category(id: idGerado + 2, userId: userId, name: "Transporte", iconName: 'directions_car'),
        Category(id: idGerado + 3, userId: userId, name: "Educação", iconName: 'school'),
        Category(id: idGerado + 4, userId: userId, name: "Trabalho", iconName: 'work'),
        Category(id: idGerado + 5, userId: userId, name: "Streaming", iconName: 'entertainment'),
        Category(id: idGerado + 6, userId: userId, name: "Viagem", iconName: 'plane'),
      ];

      for (var cat in categoriasPadrao) {
        await categoryRepo.insert(cat);
      }
    }

    return sucessoLogin;
  }

  void logout() {
    _currentUser = null; 
    notifyListeners();
  }

  Future<void> atualizarSaldo(double novoSaldo) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(balance: novoSaldo);
      
      await sl<UserRepository>().update(_currentUser!); 
      
      notifyListeners(); 
    }
  }

  Future<void> atualizarPatrimonio(double novoPatrimonio) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(patrimony: novoPatrimonio);
      
      await sl<UserRepository>().update(_currentUser!); 
      
      notifyListeners(); 
    }
  }

  void atualizarUsuarioEmMemoria(User usuarioAtualizado) {
    _currentUser = usuarioAtualizado;
    notifyListeners();
  }
  
}