import 'package:flutter/material.dart';
import 'package:invezzte/feature/widgets/HeaderScreens.dart';
import 'package:invezzte/feature/widgets/NavBar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:invezzte/domain/notifiers/user_notifier.dart';

class ProfileConfiguration extends StatelessWidget {
  const ProfileConfiguration({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const NavBar(),

      body: DefaultTextStyle(
        style: const TextStyle(fontFamily: "Poppins", color: Colors.black),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  // Mantivemos o padding padrão
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                  child: Headerscreens(
                    title: 'Meu Perfil',
                    firstIcon: Icons.search,
                    secondIcon: Icons.notifications,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? 'Usuário',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      user?.email ?? 'E-mail não disponível',
                      style: TextStyle(fontSize: 16),
                    ),

                    const SizedBox(height: 40),

                    _buildItem(
                      icon: Icons.folder_open,
                      title: "Editar Informações Pessoais",
                      subtitle: "Nome, E-mail, Gênero, Salário",
                    ),
                    const Divider(),

                    _buildItem(
                      icon: Icons.assignment_outlined,
                      title: "Editar Categorias",
                      subtitle: "Visualize as categorias cadastradas",
                      onTap: () {
                        context.push('/category');
                      },
                    ),
                    const Divider(),

                    _buildItem(
                      icon: Icons.shield_outlined,
                      title: "Privacidade",
                      subtitle: "Termo de Privacidade",
                    ),
                    const Divider(),

                    _buildItem(
                      icon: Icons.help_outline,
                      title: "Ajuda",
                      subtitle: "Tire suas dúvidas",
                    ),

                    const SizedBox(height: 80),

                    GestureDetector(
                      onTap: () {
                        // 1. Acessa o Provider e limpa o usuário (sem ficar escutando a mudança aqui)
                        Provider.of<UserProvider>(
                          context,
                          listen: false,
                        ).logout();

                        // 2. Joga o usuário de volta para a tela inicial/login
                        context.go('/login');
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEAC1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            "SAIR DO APP",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFFFFB300),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: const Color(0xFF8C4EFF), size: 30),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      contentPadding: EdgeInsets.zero,
    );
  }
}
