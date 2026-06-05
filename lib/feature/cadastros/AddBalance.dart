import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invezzte/domain/notifiers/saldo_notifier.dart';
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
import 'package:invezzte/domain/category.dart';


class AddBalance extends StatefulWidget {
  const AddBalance({super.key});

  @override
  State<AddBalance> createState() => _AddBalanceState();
}

class _AddBalanceState extends State<AddBalance> {
  final _formKey = GlobalKey<FormState>();
  late double _saldoOriginal;
  final _valorController = TextEditingController();
  final _tituloController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    DateTime hoje = DateTime.now();
    String dataFormatada =
        "${hoje.day.toString().padLeft(2, '0')}/${hoje.month.toString().padLeft(2, '0')}/${hoje.year}";
    _dateController.text = dataFormatada;

    _valorController.addListener(_atualizarPreview);
    _saldoOriginal = context.read<SaldoNotifier>().saldo;
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

Future<void> _salvarSaldo() async {
    if (_formKey.currentState!.validate()) {
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
      final categoriaNotifier = context.read<CategoriaNotifier>();

      int idCategoriaReceita = 0;
      
      try {
        idCategoriaReceita = categoriaNotifier.categorias.firstWhere((c) => c.name == 'Receitas').id;
      } catch (e) {
        final novaCategoria = Category(
          id: 0,
          userId: userId,
          name: 'Receitas',
          iconName: 'attach_money', 
        );
        
        await categoriaNotifier.addCategory(novaCategoria);
        idCategoriaReceita = categoriaNotifier.categorias.last.id; 
      }

  final novaTransacao = Transaction(
      id: 0, 
      userId: userId,
      categoryId: idCategoriaReceita, 
      title: _tituloController.text,
      amount: valor,
      date: dataSelecionada,
      type: TransactionType.income, 
    );

    await context.read<HistoricoNotifier>().adicionarTransacao(novaTransacao);

      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {

    final valorTexto = _valorController.text
        .replaceAll('.', '')
        .replaceAll(',', '.');
    final valorDigitado = double.tryParse(valorTexto) ?? 0.0;

    final saldoPreview = _saldoOriginal + valorDigitado;
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
                title: "Adicionar Recebimento",
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
                hintText: "Ex: Recebimento de Freela",
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

              const SizedBox(height: 30),

              FormButton(
                onSave: _salvarSaldo,
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
