import 'package:flutter/material.dart';
import 'package:invezzte/feature/widgets/FormButton.dart';
import 'package:invezzte/feature/widgets/HeaderForm.dart';
import 'package:invezzte/feature/widgets/InputField.dart';


class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {

  final TextEditingController _dateController = TextEditingController();


  @override
  void initState() {
    super.initState();
    
    // Pega a data exata do momento em que a tela abriu
    DateTime hoje = DateTime.now();
    
    // Formata para o padrão DD/MM/AAAA
    String dataFormatada = 
        "${hoje.day.toString().padLeft(2, '0')}/${hoje.month.toString().padLeft(2, '0')}/${hoje.year}";
    
    // Já deixa o campo preenchido por padrão!
    _dateController.text = dataFormatada;
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    // Abre o calendário do Flutter
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Data que vem marcada (hoje)
      firstDate: DateTime(2000), // Data mínima que o usuário pode escolher
      lastDate: DateTime(2100), // Data máxima
      
      // (Opcional) Deixando o calendário com as cores do Invezzte!
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF8F64FF), // Cor do cabeçalho e seleção
              onPrimary: Colors.white, // Cor do texto no cabeçalho
              onSurface: Colors.black, // Cor do texto do calendário
            ),
          ),
          child: child!,
        );
      },
    );

    // Se o usuário selecionou uma data (não clicou em cancelar)
    if (pickedDate != null) {
      // Formatamos a data para DD/MM/AAAA
      String formattedDate = 
          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
      
      // Atualizamos o campo de texto
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.grey, size: 30),
          tooltip: "Fechar",
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // 1. Nosso Header Reutilizável
            const Headerform(
              title: "Adicionar Despesa",
              balanceInteger: "3212",
              balanceDecimal: ",66",
            ),
            const SizedBox(height: 30),

            // 2. Nossos Inputs Reutilizáveis
            const Inputfield(
              label: "Valor:",
              hintText: "R\$ 1.356,99",
              prefixIcon: Icons.monetization_on_outlined,
            ),
            const Inputfield(
              label: "Título:",
              hintText: "Ex: Conta de Água",
              prefixIcon: Icons.description_outlined,
            ),
            Inputfield(
              label: "Data:",
              hintText: "03/05/2026",
              prefixIcon: Icons.calendar_today_outlined,
              controller: _dateController,
              onTap: () => _selectDate(context),
              
            ),
            Inputfield(
              label: "Categoria:",
              hintText: "Selecione aqui",
              isDropdown: true,
              prefixIcon: Icons.category_outlined,
              onTap: () {
                print("Abrir seleção de categoria");
              },
            ),
            
            const SizedBox(height: 20),

            // 3. Nossos Botões Reutilizáveis
            FormButton(
              onSave: () {
                print("Salvar clicado");
              },
              onCancel: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 30), // Espaço no fundo da tela
          ],
        ),
      ),
    );
  }
}