import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invezzte/domain/notifiers/user_notifier.dart';
import 'package:invezzte/core/injecao.dart';
import 'package:invezzte/domain/repositories/user_repository.dart';
import 'package:invezzte/feature/widgets/FormButton.dart';
import 'package:invezzte/feature/widgets/HeaderForm.dart';
import 'package:invezzte/feature/widgets/InputField.dart';
import 'package:invezzte/feature/widgets/SectionTitle.dart';
import 'package:invezzte/domain/suporte/Validacoes.dart';
import 'package:invezzte/domain/enums.dart'; 

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  
  Gender? _selectedGender; 

  bool _isLoading = false;

  String _traduzirGenero(Gender genero) {
  switch (genero) {
    case Gender.male:
      return 'Masculino';
    case Gender.female:
      return 'Feminino';
    case Gender.other:
      return 'Outro';
    case Gender.preferNotToSay: // Verifique se é assim que está no seu enums.dart
      return 'Prefiro não informar';
    default:
      return genero.name;
  }
}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.read<UserProvider>().currentUser;
      if (user != null) {
        _nomeController.text = user.name ?? "";
        _emailController.text = user.email ?? "";
        
        setState(() {
          _selectedGender = user.gender; 
        });
      }
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _salvarPerfil() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final userProvider = context.read<UserProvider>();
      final userAtual = userProvider.currentUser;

      if (userAtual != null) {
        final userAtualizado = userAtual.copyWith(
          name: _nomeController.text.trim(),
          email: _emailController.text.trim(),
          gender: _selectedGender, 
        );

        await sl<UserRepository>().update(userAtualizado);

        userProvider.atualizarUsuarioEmMemoria(userAtualizado);
      }

      if (!mounted) return;
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil atualizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      
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
              const Headerform(title: "Seu Perfil"),
              const SizedBox(height: 10),
              const Text(
                "Consulte ou altere as suas informações cadastrais.",
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

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Gênero",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<Gender>( 
                    value: _selectedGender,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                    decoration: InputDecoration(
                      hintText: "Prefiro não informar...",
                      prefixIcon: const Icon(Icons.wc_outlined, color: Color(0xFF8F64FF)),
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
                      fillColor: Colors.grey[100],
                    ),

                    items: Gender.values.map((Gender generoItem) {
                      return DropdownMenuItem<Gender>(
                        value: generoItem,
                        child: Text(
                          _traduzirGenero(generoItem), 
                        ),
                      );
                    }).toList(),
                    onChanged: (novoGenero) {
                      setState(() {
                        _selectedGender = novoGenero;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 100),

              IgnorePointer(
                ignoring: _isLoading,
                child: Opacity(
                  opacity: _isLoading ? 0.5 : 1.0,
                  child: FormButton(
                    onSave: _salvarPerfil, 
                    onCancel: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}