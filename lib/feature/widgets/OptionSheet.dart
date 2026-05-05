import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddOptionsSheet extends StatelessWidget {
  const AddOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          _buildOption(Icons.cut, "Cadastrar Despesas", () {
            Navigator.pop(context); 
            context.push('/add-expense');
          }),
          const Divider(),
          
          _buildOption(Icons.payments_outlined, "Adicionar Saldo", () {
            Navigator.pop(context); 
            context.push('/add-balance');
          }),
          const Divider(),
          _buildOption(Icons.assignment_outlined, "Cadastrar Categoria", () {}),
        ],
      ),
    );
  }

  Widget _buildOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF8F64FF)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}