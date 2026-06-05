import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invezzte/domain/category.dart';
import 'package:invezzte/domain/notifiers/categoria_notifier.dart';
import 'package:invezzte/domain/notifiers/user_notifier.dart';

class CategoryCreate extends StatefulWidget {

  final Category? categoriaParaEditar;

  const CategoryCreate({super.key, this.categoriaParaEditar});

  @override
  State<CategoryCreate> createState() => _CategoryCreateState();
}

class _CategoryCreateState extends State<CategoryCreate> {
  final _nomeController = TextEditingController();
  
  final List<Map<String, dynamic>> iconesDisponiveis = [
    {'name': 'home', 'icon': Icons.home},
    {'name': 'directions_car', 'icon': Icons.directions_car},
    {'name': 'shopping_cart', 'icon': Icons.shopping_cart},
    {'name': 'restaurant', 'icon': Icons.restaurant},
    {'name': 'work', 'icon': Icons.work},
    {'name': 'account_balance_wallet', 'icon': Icons.account_balance_wallet},
    {'name': 'fitness_center', 'icon': Icons.fitness_center},
    {'name': 'local_hospital', 'icon': Icons.local_hospital},
  ];

  late String _selectedIconName;
  late IconData _selectedIconData;

  @override
  void initState() {
    super.initState();
    
    if (widget.categoriaParaEditar != null) {
      _nomeController.text = widget.categoriaParaEditar!.name;
      _selectedIconName = widget.categoriaParaEditar!.iconName;
      
      final iconMap = iconesDisponiveis.firstWhere(
        (item) => item['name'] == _selectedIconName,
        orElse: () => iconesDisponiveis[0],
      );
      _selectedIconData = iconMap['icon'];
    } else {
      _selectedIconName = iconesDisponiveis[0]['name'];
      _selectedIconData = iconesDisponiveis[0]['icon'];
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _abrirSeletorDeIcones(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Escolha um ícone",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: iconesDisponiveis.length,
                itemBuilder: (ctx, index) {
                  final item = iconesDisponiveis[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIconName = item['name'];
                        _selectedIconData = item['icon'];
                      });
                      Navigator.pop(ctx);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selectedIconName == item['name'] 
                            ? const Color(0xFFD1BFFF) 
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        item['icon'],
                        color: const Color(0xFF8F64FF),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _salvarCategoria() async {
    final nomeDigitado = _nomeController.text.trim();

    if (nomeDigitado.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, digite um título para a categoria.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final userId = context.read<UserProvider>().currentUser!.id;

    if (widget.categoriaParaEditar != null) {

      final catAtualizada = widget.categoriaParaEditar!.copyWith(
        name: nomeDigitado,
        iconName: _selectedIconName,
      );
      
      await context.read<CategoriaNotifier>().atualizarCategoria(catAtualizada);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Categoria atualizada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {

      final novaCategoria = Category(
        id: 0, 
        userId: userId,
        name: nomeDigitado,
        iconName: _selectedIconName,
      );

      await context.read<CategoriaNotifier>().addCategory(novaCategoria);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Categoria criada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    final tituloTela = widget.categoriaParaEditar != null 
        ? "Edite sua Categoria!" 
        : "Crie suas Categorias!";

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.grey, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              tituloTela, 
              style: const TextStyle(
                color: Color(0xFFFBB718),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),

            GestureDetector(
              onTap: () => _abrirSeletorDeIcones(context),
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF1CF),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _selectedIconData, 
                  size: 60,
                  color: const Color(0xFFFFCA66),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Título:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                hintText: "Ex: Academia",
                hintStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFD1BFFF),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF8F64FF),
                    width: 2,
                  ),
                ),
              ),
            ),

            const Spacer(), 

            // Botão Salvar
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _salvarCategoria, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE5A5),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "SALVAR",
                  style: TextStyle(
                    color: Color(0xFFFBB016),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Botão Cancelar
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD1BFFF), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "CANCELAR",
                  style: TextStyle(
                    color: Color(0xFF8F64FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}