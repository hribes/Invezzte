// import 'package:flutter/material.dart';
// import '/domain/category.dart';

// class CategoriaNotifier with ChangeNotifier {
//   List<Category> _categorias = [];

//   List<Category> get categorias => [..._categorias];

//   // Adicione este método para popular o app
//   void carregarCategoriasMock() {
//     _categorias = [
//       const Category(
//         id: 1,
//         userId: 1,
//         name: "Casa",
//         iconName: 'home',
//       ),
//       const Category(
//         id: 2,
//         userId: 1,
//         name: "Transporte",
//         iconName: 'directions_car',
//       ),
//       const Category(
//         id: 3,
//         userId: 1,
//         name: "Educação",
//         iconName: 'school',
//       ),
//       const Category(
//         id: 4,
//         userId: 1,
//         name: "Trabalho",
//         iconName: 'work',
//       ),
//       const Category(
//         id: 5,
//         userId: 1,
//         name: "Streaming",
//         iconName: 'entertainment',
//       ),
//       const Category(
//         id: 6,
//         userId: 1,
//         name: "Viagem",
//         iconName: 'plane',

//       ),
//     ];
//     notifyListeners(); // ISSO FARÁ A TELA ATUALIZAR
//   }

//   void setCategorias(List<Category> novasCategorias) {
//     _categorias = novasCategorias;
//     notifyListeners();
//   }

//   Category? findById(int id) {
//     try {
//       return _categorias.firstWhere((cat) => cat.id == id);
//     } catch (e) {
//       return null;
//     }
//   }

//   void addCategory(Category category) {
//     _categorias.add(category);
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:invezzte/domain/category.dart';
import 'package:invezzte/core/injecao.dart';
import 'package:invezzte/domain/repositories/category_repository.dart';

class CategoriaNotifier with ChangeNotifier {
  List<Category> _categorias = [];

  List<Category> get categorias => [..._categorias];

  // Busca as categorias reais no banco de dados
  Future<void> carregarCategoriasDoBanco(int userId) async {
    final repository = sl<CategoryRepository>();
    final categoriasBuscadas = await repository.getByUserId(userId);
    
    _categorias = categoriasBuscadas;
    notifyListeners();
  }

  // Adiciona a categoria no banco e depois atualiza a tela
  Future<void> addCategory(Category category) async {
    final repository = sl<CategoryRepository>();
    
    // Insere no SQLite. O banco vai gerar o ID automaticamente.
    await repository.insert(category);
    
    // Recarrega a lista para garantir que estamos com os dados sincronizados
    await carregarCategoriasDoBanco(category.userId);
  }

  Category? findById(int id) {
    try {
      return _categorias.firstWhere((cat) => cat.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> deletarCategoria(int categoryId) async {
    final repository = sl<CategoryRepository>();
    
    await repository.delete(categoryId);
    
    _categorias.removeWhere((c) => c.id == categoryId);
    notifyListeners();
  }

  Future<void> atualizarCategoria(Category categoriaAtualizada) async {
    final repository = sl<CategoryRepository>();
    
    await repository.update(categoriaAtualizada);
    
    final index = _categorias.indexWhere((c) => c.id == categoriaAtualizada.id);
    if (index != -1) {
      _categorias[index] = categoriaAtualizada;
      notifyListeners();
    }
  }
}
