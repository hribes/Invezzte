import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invezzte/feature/widgets/InputField.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Imagem de Fundo com Overlay Roxo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_login.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF8F64FF).withOpacity(0.8),
              ),
            ),
          ),

          // 2. Conteúdo Superior (Logo e Texto)
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                Center(
                  child: Column(
                    children: [
                      // Carregamento da Logo
                      Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "INVEZZTE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Bem-Vindo!",
                  style: TextStyle(
                    color: Color(0xFFFFD700), // Amarelo/Dourado
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Do CDB ao Bitcoin:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "tudo na sua mão.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // 3. Formulário Branco Inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Inputfield(
                      label: "E-mail",
                      hintText: "lucas.hygidio@gmail.com",
                      prefixIcon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 20),
                    const Inputfield(
                      label: "Senha",
                      hintText: "**************",
                      prefixIcon: Icons.lock_outline,
                    ),
                    const SizedBox(height: 40),

                    // Botão ENTRAR
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFFFE5A5,
                          ), // Amarelo claro
                          foregroundColor: const Color(
                            0xFFFBB016,
                          ), // Texto laranja/ouro
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          context.go('/home');
                        },
                        child: const Text(
                          "ENTRAR",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Link para Cadastro
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Não possui conta? "),
                          GestureDetector(
                            onTap: () => context.push('/register-user'),
                            child: const Text(
                              "Clique aqui!",
                              style: TextStyle(
                                color: Color(0xFF8F64FF),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
