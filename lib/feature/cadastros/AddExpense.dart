import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:invezzte/feature/widgets/FormButton.dart';
import 'package:invezzte/feature/widgets/HeaderForm.dart';
import 'package:invezzte/feature/widgets/InputField.dart';
import 'package:invezzte/domain/suporte/Validacoes.dart';
import 'package:invezzte/domain/suporte/MoedaFormatter.dart';
import 'package:invezzte/domain/notifiers/user_notifier.dart';
import 'package:invezzte/domain/notifiers/historico_notifier.dart';
import 'package:invezzte/domain/notifiers/categoria_notifier.dart';
import 'package:invezzte/domain/transaction.dart';
import 'package:invezzte/domain/enums.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();
  late double _saldoOriginal;

  final _valorController = TextEditingController();
  final _tituloController = TextEditingController();
  final _dateController = TextEditingController();
  
  int? _selectedCategoryId; 

  @override
  void initState() {
    super.initState();
    DateTime hoje = DateTime.now();
    String dataFormatada =
        "${hoje.day.toString().padLeft(2, '0')}/${hoje.month.toString().padLeft(2, '0')}/${hoje.year}";
    _dateController.text = dataFormatada;

    _valorController.addListener(_atualizarPreview);
    _saldoOriginal = context.read<UserProvider>().currentUser?.balance ?? 0.0;
  }

  void _atualizarPreview() {
    setState(() {});
  }

  @override
  void dispose() {
    _valorController.removeListener(_atualizarPreview);
    _valorController.dispose();
    _tituloController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF8F64FF),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  bool _isSaving = false;
  Future<void> _salvarDespesa() async {
    if (_isSaving) return;
    if (_formKey.currentState!.validate()) {

      setState(() => _isSaving = true);
      
      final valorTexto = _valorController.text
          .replaceAll('.', '')
          .replaceAll(',', '.');
      final valor = double.tryParse(valorTexto) ?? 0.0;

      final partesData = _dateController.text.split('/');
      final dataSelecionada = DateTime(
        int.parse(partesData[2]),
        int.parse(partesData[1]),
        int.parse(partesData[0]),
      );

      final userProvider = context.read<UserProvider>();
      final userId = userProvider.currentUser!.id;

      final novaTransacao = Transaction(
        id: 0,
        userId: userId,
        categoryId: _selectedCategoryId!, 
        title: _tituloController.text,
        amount: valor,
        date: dataSelecionada,
        type: TransactionType.expense, 
      );

      await context.read<HistoricoNotifier>().adicionarTransacao(novaTransacao);

      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Buscamos as categorias e filtramos "Receitas" fora da lista!
    final categoriasDespesa = context.watch<CategoriaNotifier>().categorias
        .where((cat) => cat.name != 'Receitas')
        .toList();

    final valorTexto = _valorController.text
        .replaceAll('.', '')
        .replaceAll(',', '.');
    final valorDigitado = double.tryParse(valorTexto) ?? 0.0;

    final saldoPreview = _saldoOriginal - valorDigitado;
    final partes = saldoPreview.toStringAsFixed(2).split('.');
    final inteiro = partes[0];
    final decimal = ',${partes[1]}';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.grey, size: 30),
          tooltip: "Fechar",
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Headerform(
                title: "Adicionar Despesa",
                balanceInteger: inteiro,
                balanceDecimal: decimal,
              ),
              const SizedBox(height: 30),

              InputField(
                label: "Valor:",
                hintText: "1.356,99",
                prefixIcon: Icons.monetization_on_outlined,
                controller: _valorController,
                keyboardType: TextInputType.number,
                inputFormatters: [MoedaFormatter()],
                validator: (val) =>
                    Validacoes.obrigatorio(val, campo: "O valor"),
              ),
              const SizedBox(height: 15),

              InputField(
                label: "Título:",
                hintText: "Ex: Conta de Água",
                prefixIcon: Icons.description_outlined,
                controller: _tituloController,
                validator: (val) =>
                    Validacoes.obrigatorio(val, campo: "O título"),
              ),
              const SizedBox(height: 15),

              InputField(
                label: "Data:",
                hintText: "03/05/2026",
                prefixIcon: Icons.calendar_today_outlined,
                controller: _dateController,
                onTap: () => _selectDate(context),
                validator: (val) =>
                    Validacoes.obrigatorio(val, campo: "A data"),
              ),
              const SizedBox(height: 15),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Categoria:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<int>(
                    value: _selectedCategoryId,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                    decoration: InputDecoration(
                      hintText: "Selecione aqui",
                      prefixIcon: const Icon(Icons.category_outlined, color: Color(0xFF8F64FF)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xFF8F64FF), width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100], // Mesmo fundo dos outros inputs
                    ),
                    items: categoriasDespesa.map((cat) {
                      return DropdownMenuItem<int>(
                        value: cat.id,
                        child: Text(cat.name),
                      );
                    }).toList(),
                    onChanged: (novoId) {
                      setState(() {
                        _selectedCategoryId = novoId;
                      });
                    },
                    validator: (val) {
                      if (val == null) return "A categoria é obrigatória";
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),

              FormButton(
                onSave: _salvarDespesa,
                onCancel: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}