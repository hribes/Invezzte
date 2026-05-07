import 'package:flutter/material.dart';
import 'package:invezzte/feature/widgets/FormButton.dart';
import 'package:invezzte/feature/widgets/HeaderForm.dart';
import 'package:invezzte/feature/widgets/InputField.dart';
import 'package:invezzte/feature/widgets/SectionTitle.dart';

class RegisterUser extends StatelessWidget {
  const RegisterUser({super.key});

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
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinha textos descritivos à esquerda
          children: [
            const Headerform(title: "Faça seu Cadastro!"),
            const SizedBox(height: 10),
            const Text(
              "Cadastre-se em nosso app para acompanhar de perto suas finanças.",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 30),

            // --- SEÇÃO: DADOS PESSOAIS ---
            const Align(
              alignment: Alignment.centerLeft,
              child: SectionTitle(title: "Dados Pessoais"),
            ),
            const SizedBox(height: 20),

            const Inputfield(
              label: "Nome Completo",
              hintText: "Digite seu nome completo...",
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 15),

            const Inputfield(
              label: "E-mail",
              hintText: "Ex: email@gmail.com",
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 15),

            const Inputfield(
              label: "Gênero",
              hintText: "Prefiro não informar...",
              prefixIcon: Icons.wc_outlined,
              isDropdown: true,
            ),

            const SizedBox(height: 30),

            // --- SEÇÃO: RENDA ---
            const Align(
              alignment: Alignment.centerLeft,
              child: SectionTitle(title: "Adicione sua Renda"),
            ),
            const SizedBox(height: 20),

            const Inputfield(
              label: "Salário",
              hintText: "Ex: R\$1.900,00",
              prefixIcon: Icons.monetization_on_outlined,
            ),
            const SizedBox(height: 15),

            // Linha com dois campos lado a lado
            Row(
              children: [
                Expanded(
                  child: const Inputfield(
                    label: "Frequência",
                    hintText: "Mensal",
                    isDropdown: true,
                    // Se o seu Inputfield não tiver ícone, ele deve lidar com o null
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: const Inputfield(
                    label: "Dt. recebimento",
                    hintText: "01/05/2026",
                    isDropdown: true,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // --- SEÇÃO: SEGURANÇA ---
            const Align(
              alignment: Alignment.centerLeft,
              child: SectionTitle(title: "Segurança"),
            ),
            const SizedBox(height: 20),

            const Inputfield(
              label: "Digite sua senha",
              hintText: "Sua senha precisa conter 6 caracteres",
              prefixIcon: Icons.lock_outline,
            ),
            const SizedBox(height: 15),

            const Inputfield(
              label: "Confirme sua senha",
              hintText: "Precisa ser igual",
              prefixIcon: Icons.lock_outline,
            ),

            const SizedBox(height: 40),

            FormButton(
              onSave: () {
                print("Cadastro realizado!");
              },
              onCancel: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
