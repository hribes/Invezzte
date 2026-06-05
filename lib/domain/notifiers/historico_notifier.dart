import 'package:flutter/material.dart';
import 'package:invezzte/domain/category.dart';
import 'package:invezzte/domain/transaction.dart';
import 'package:invezzte/domain/enums.dart';
import 'package:invezzte/core/injecao.dart';
import 'package:invezzte/domain/repositories/transaction_repository.dart';
import 'package:invezzte/domain/notifiers/saldo_notifier.dart';
import 'package:invezzte/domain/notifiers/user_notifier.dart';

class HistoricoNotifier with ChangeNotifier {
  List<Transaction> _transacoes = [];
  List<Category> _todasCategorias = [];

  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'Todas';

  // Getters
  List<Transaction> get transacoes => List.unmodifiable(_transacoes);
  DateTime get selectedDate => _selectedDate;
  String get selectedCategory => _selectedCategory;

  List<Transaction> get despesasFiltradas {
    return _transacoes.where((tx) {
      final bool isNotIncome = tx.type != TransactionType.income;
      
      final String nomeCategoriaTx = _getCategoryNameById(tx.categoryId);
      final bool categoryMatch = _selectedCategory == 'Todas' || nomeCategoriaTx == _selectedCategory;

      final bool dateMatch = tx.date.month == _selectedDate.month && tx.date.year == _selectedDate.year;

      return isNotIncome && categoryMatch && dateMatch;
    }).toList();
  }

  List<Transaction> get historicoCompleto =>
      [..._transacoes]..sort((a, b) => b.date.compareTo(a.date));

  String _getCategoryNameById(int id) {
    final cat = _todasCategorias.firstWhere(
      (c) => c.id == id,
      orElse: () => const Category(id: 0, userId: 0, name: 'Outros', iconName: 'help'),
    );
    return cat.name;
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void carregarCategorias(List<Category> cats) {
    _todasCategorias = cats;
    notifyListeners();
  }


  Future<void> carregarTransacoesDoBanco(int userId) async {
    final repository = sl<TransactionRepository>();
    final transacoesBuscadas = await repository.getByUserId(userId);
    
    _transacoes = List.from(transacoesBuscadas);
    notifyListeners();
  }

  Future<void> adicionarTransacao(Transaction t) async {
    final repository = sl<TransactionRepository>();
    
    await repository.insert(t);
  
    final saldoNotifier = sl<SaldoNotifier>();
    if (t.type == TransactionType.income) {
      await saldoNotifier.adicionarSaldo(t.amount);
    } else {
      await saldoNotifier.retirarSaldo(t.amount);
    }
 
    await carregarTransacoesDoBanco(t.userId);
    notifyListeners();
  }

  Future<void> deletarTransacao(int transactionId, int userId) async {
    final repository = sl<TransactionRepository>();
    
    await repository.delete(transactionId);
    
    await carregarTransacoesDoBanco(userId);
    notifyListeners();
  }

  Future<void> inicializarHistorico() async {
    final user = sl<UserProvider>().currentUser;
    if (user != null) {
      await carregarTransacoesDoBanco(user.id);
    }
  }
}