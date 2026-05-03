// import 'package:flutter/material.dart';
// import 'package:invezzte/features/investimento/presentation/investment.dart';

// void main() {
//   runApp(const InvezzteApp());
// }

// class InvezzteApp extends StatelessWidget {
//   const InvezzteApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Invezzte',
//       theme: ThemeData(fontFamily: 'Poppins', primarySwatch: Colors.blue),
//       home: const Investment(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fundo roxo principal
      backgroundColor: const Color(0xFF885CFB),
      body: Column(
        children: [
          // Espaço superior (pode ser usado para logo ou ilustração)
          const Expanded(flex: 2, child: SizedBox()),

          // Container Branco com bordas arredondadas
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Campo de E-mail
                    const Text(
                      "E-mail",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "lucas.hygidio@gmail.com",
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.orangeAccent,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFE0D7FF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Campo de Senha
                    const Text(
                      "Senha",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "*************",
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.orangeAccent,
                        ),
                        suffixIcon: const Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.orangeAccent,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFE0D7FF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Botão Entrar
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFFFE5B4,
                          ), // Tom pastel do botão
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "ENTRAR",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Texto de Cadastro
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: RichText(
                          text: const TextSpan(
                            text: "Não possui conta? ",
                            style: TextStyle(color: Colors.black54),
                            children: [
                              TextSpan(
                                text: "Clique aqui!",
                                style: TextStyle(
                                  color: Color(0xFF8B5CF6),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
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
