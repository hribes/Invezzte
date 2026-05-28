import 'package:flutter/material.dart';
import '/domain/category.dart';

class CategoriaNotifier with ChangeNotifier {
  List<Category> _categorias = [];

  List<Category> get categorias => [..._categorias];

  // Adicione este método para popular o app
  void carregarCategoriasMock() {
    _categorias = [
      const Category(
        id: 1,
        userId: 1,
        name: "Casa",
        iconName: 'home',
        colorHex: '#8C4EFF',
      ),
      const Category(
        id: 2,
        userId: 1,
        name: "Transporte",
        iconName: 'directions_car',
        colorHex: '#FFB300',
      ),
      const Category(
        id: 3,
        userId: 1,
        name: "Educação",
        iconName: 'school',
        colorHex: '#FF5733',
      ),
      const Category(
        id: 4,
        userId: 1,
        name: "Trabalho",
        iconName: 'work',
        colorHex: '#33FF57',
      ),
      const Category(
        id: 5,
        userId: 1,
        name: "Streaming",
        iconName: 'entertainment',
        colorHex: '#33FF57',
      ),
      const Category(
        id: 6,
        userId: 1,
        name: "Viagem",
        iconName: 'plane',
        colorHex: '#33FF57',
      ),
    ];
    notifyListeners(); // ISSO FARÁ A TELA ATUALIZAR
  }

  void setCategorias(List<Category> novasCategorias) {
    _categorias = novasCategorias;
    notifyListeners();
  }

  Category? findById(int id) {
    try {
      return _categorias.firstWhere((cat) => cat.id == id);
    } catch (e) {
      return null;
    }
  }

  void addCategory(Category category) {
    _categorias.add(category);
    notifyListeners();
  }
}
