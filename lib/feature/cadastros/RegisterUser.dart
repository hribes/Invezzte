import 'package:flutter/material.dart';
import 'package:invezzte/feature/widgets/FormButton.dart';
import 'package:invezzte/feature/widgets/HeaderForm.dart';
import 'package:invezzte/feature/widgets/InputField.dart';
import 'package:invezzte/feature/widgets/SectionTitle.dart';
import 'package:invezzte/domain/suporte/Validacoes.dart';
import 'package:invezzte/domain/suporte/MoedaFormatter.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _generoController = TextEditingController();
  final _salarioController = TextEditingController();
  final _frequenciaController = TextEditingController();
  final _dataRecebimentoController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _generoController.dispose();
    _salarioController.dispose();
    _frequenciaController.dispose();
    _dataRecebimentoController.dispose();
    _senhaController.dispose();
    _confirmaSenhaController.dispose();
    super.dispose();
  }

  void _salvarCadastro() {
    if (_formKey.currentState!.validate()) {
      print("Cadastro Validado e Realizado!");
      Navigator.of(context).pop();
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
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Headerform(title: "Faça seu Cadastro!"),
              const SizedBox(height: 10),
              const Text(
                "Cadastre-se em nosso app para acompanhar de perto suas finanças.",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: SectionTitle(title: "Dados Pessoais"),
              ),
              const SizedBox(height: 20),

              InputField(
                label: "Nome Completo",
                hintText: "Digite seu nome completo...",
                prefixIcon: Icons.person_outline,
                controller: _nomeController,
                validator: Validacoes.nomeCompleto,
              ),
              const SizedBox(height: 15),

              InputField(
                label: "E-mail",
                hintText: "Ex: email@gmail.com",
                prefixIcon: Icons.email_outlined,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: Validacoes.email,
              ),
              const SizedBox(height: 15),

              InputField(
                label: "Gênero",
                hintText: "Prefiro não informar...",
                prefixIcon: Icons.wc_outlined,
                isDropdown: true,
                controller: _generoController,
                onTap: () {
        
                  _generoController.text = "Masculino"; // Exemplo
                },
              ),

              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: SectionTitle(title: "Adicione sua Renda"),
              ),
              const SizedBox(height: 20),

              InputField(
                label: "Salário",
                hintText: "Ex: 1.900,00",
                prefixIcon: Icons.monetization_on_outlined,
                controller: _salarioController,
                keyboardType: TextInputType.number,
                inputFormatters: [MoedaFormatter()],
                validator: (val) =>
                    Validacoes.obrigatorio(val, campo: 'O salário'),
              ),
              const SizedBox(height: 15),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InputField(
                      label: "Frequência",
                      hintText: "Mensal",
                      isDropdown: true,
                      controller: _frequenciaController,
                      onTap: () => _frequenciaController.text = "Mensal",
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: InputField(
                      label: "Dt. recebimento",
                      hintText: "01/05/2026",
                      isDropdown: true,
                      controller: _dataRecebimentoController,
                      onTap: () =>
                          _dataRecebimentoController.text = "05/05/2026",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: SectionTitle(title: "Segurança"),
              ),
              const SizedBox(height: 20),

              InputField(
                label: "Digite sua senha",
                hintText: "Mínimo 8 caracteres (1 maiúscula, 1 número)",
                prefixIcon: Icons.lock_outline,
                controller: _senhaController,
                obscureText: true,
                validator: Validacoes.senha,
              ),
              const SizedBox(height: 15),

              InputField(
                label: "Confirme sua senha",
                hintText: "Precisa ser igual",
                prefixIcon: Icons.lock_outline,
                controller: _confirmaSenhaController,
                obscureText: true,
                validator: (val) =>
                    Validacoes.confirmarSenha(_senhaController.text)(val),
              ),

              const SizedBox(height: 40),

              FormButton(
                onSave: _salvarCadastro,
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
