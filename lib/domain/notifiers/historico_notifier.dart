import 'package:flutter/material.dart';
import 'package:invezzte/domain/category.dart';
import '/domain/transaction.dart';
import '/domain/enums.dart';

class HistoricoNotifier with ChangeNotifier {
  List<Transaction> _transacoes = [];
  List<Category> _todasCategorias = [];

  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'Todas';

  // Getters
  List<Transaction> get transacoes => List.unmodifiable(_transacoes);
  DateTime get selectedDate => _selectedDate;
  String get selectedCategory => _selectedCategory;

  // 1. Home: Próximos pagamentos
  List<Transaction> get proximosPagamentos =>
      _transacoes
          .where(
            (t) =>
                t.status == TransactionStatus.pending ||
                t.date.isAfter(DateTime.now()),
          )
          .toList()
        ..sort((a, b) => a.date.compareTo(b.date));

  List<Transaction> get despesasFiltradas {
    return _transacoes.where((tx) {
      final bool isNotIncome = tx.type != TransactionType.income;
      final String nomeCategoriaTx = _getCategoryNameById(tx.categoryId);
      final bool categoryMatch =
          _selectedCategory == 'Todas' || nomeCategoriaTx == _selectedCategory;

      // 3. Filtro de data
      final bool dateMatch =
          tx.date.month == _selectedDate.month &&
          tx.date.year == _selectedDate.year;

      String nomeCat = _getCategoryNameById(tx.categoryId);
      bool match =
          (_selectedCategory == 'Todas' || nomeCat == _selectedCategory);

      print(
        "DEBUG: Comparando Cat da Tx: '$nomeCat' com Selecionada: '$_selectedCategory'. Match: $match",
      );

      return isNotIncome && categoryMatch && dateMatch;
    }).toList();
  }

  // 3. Histórico completo (Para relatórios gerais - Inclui tudo)
  List<Transaction> get historicoCompleto =>
      [..._transacoes]..sort((a, b) => b.date.compareTo(a.date));

  // Método auxiliar
  String _getCategoryNameById(int id) {
    final cat = _todasCategorias.firstWhere(
      (c) => c.id == id,
      orElse: () =>
          const Category(id: 0, userId: 0, name: 'Outros', iconName: 'help'),
    );
    return cat.name;
  }

  // Métodos de Filtro
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

  // Métodos de Ação
  void adicionarTransacao(Transaction t) {
    _transacoes.add(t);
    notifyListeners();
  }

  void carregarDadosMock() {
    _transacoes = [
      Transaction(
        id: 1,
        userId: 1,
        categoryId: 5,
        title: "Amazon Prime",
        amount: 30.0,
        date: DateTime.now(),
        type: TransactionType.expense,
        tag: TransactionTag.variable,
      ),
      Transaction(
        id: 2,
        userId: 1,
        categoryId: 1,
        title: "Água",
        amount: 130.98,
        date: DateTime.now(),
        type: TransactionType.expense,
        tag: TransactionTag.fixed,
      ),
      Transaction(
        id: 3,
        userId: 1,
        categoryId: 3,
        title: "Curso Python",
        amount: 432.75,
        date: DateTime.now(),
        type: TransactionType.expense,
        tag: TransactionTag.fixed,
      ),
      Transaction(
        id: 4,
        userId: 1,
        categoryId: 2,
        title: "Onibus",
        amount: 432.75,
        date: DateTime.now(),
        type: TransactionType.expense,
        tag: TransactionTag.fixed,
      ),
      Transaction(
        id: 5,
        userId: 1,
        categoryId: 1,
        title: "Luz",
        amount: 105.90,
        date: DateTime.now(),
        type: TransactionType.expense,
        tag: TransactionTag.fixed,
      ),
      Transaction(
        id: 6,
        userId: 1,
        categoryId: 1,
        title: "Venda do sofá",
        amount: 105.90,
        date: DateTime.now(),
        type: TransactionType.income,
        tag: TransactionTag.fixed,
      ),
      Transaction(
        id: 7,
        userId: 1,
        categoryId: 6,
        title: "Viagem Paris",
        amount: 5086.96,
        date: DateTime.now(),
        type: TransactionType.expense,
        tag: TransactionTag.fixed,
      ),
    ];
    notifyListeners();
  }

  void atualizarStatus(int id, TransactionStatus novoStatus) {
    final index = _transacoes.indexWhere((t) => t.id == id);
    if (index != -1) {
      _transacoes[index] = _transacoes[index].copyWith(status: novoStatus);
      notifyListeners();
    }
  }
}
