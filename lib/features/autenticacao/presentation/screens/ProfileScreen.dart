import 'package:flutter/material.dart';
import 'package:invezzte/features/autenticacao/domain/models/user.dart';

// Considerando que sua model User está no mesmo arquivo ou importada
class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header: Título e Ícones de Busca/Notificação
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Meu Perfil',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      _buildHeaderCircleIcon(Icons.search),
                      const SizedBox(width: 12),
                      _buildHeaderCircleIcon(Icons.notifications),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Informações do Usuário (Vindas da sua Model)
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                user.email,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 40),

              // Lista de Opções do Menu
              _buildMenuOption(
                icon: Icons.folder_open_outlined,
                title: 'Editar Informações Pessoais',
                subtitle: 'Nome, E-mail, Gênero, Salário',
              ),
              const Divider(color: Color(0xFFF5F5F5), height: 1),
              _buildMenuOption(
                icon: Icons.shield_outlined,
                title: 'Privacidade',
                subtitle: 'Termo de Privacidade',
              ),
              const Divider(color: Color(0xFFF5F5F5), height: 1),
              _buildMenuOption(
                icon: Icons.help_outline,
                title: 'Ajuda',
                subtitle: 'Tire suas dúvidas',
              ),
              const Divider(color: Color(0xFFF5F5F5), height: 1),

              const Spacer(),

              // Botão Sair do App
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Adicione sua lógica de logout aqui
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFEAB4), // Amarelo claro
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'SAIR DO APP',
                    style: TextStyle(
                      color: Color(0xFFF5B433), // Texto Laranja/Amarelo
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
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

  // Widget para os ícones roxos circulares do topo
  Widget _buildHeaderCircleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF9173FF), // Roxo principal
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }

  // Widget para construir cada item da lista
  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      onTap: () {
        // Ação ao clicar na opção
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF9173FF), size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF9173FF),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
