import 'package:flutter/material.dart';
import 'package:invezzte/feature/widgets/NavBar.dart';

class ProfileConfiguration extends StatelessWidget {
  const ProfileConfiguration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(),

      // AQUI fica o DefaultTextStyle
      body: DefaultTextStyle(
        style: const TextStyle(
          fontFamily: "Poppins",
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  Text(
                    'Lucas Hygidio',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'lucas.hygidio@gmail.com',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 40),

                  _buildItem(
                    icon: Icons.folder_open,
                    title: "Editar Informações Pessoais",
                    subtitle: "Nome, E-mail, Gênero, Salário",
                  ),
                  Divider(),

                  _buildItem(
                    icon: Icons.shield_outlined,
                    title: "Privacidade",
                    subtitle: "Termo de Privacidade",
                  ),
                  Divider(),

                  _buildItem(
                    icon: Icons.help_outline,
                    title: "Ajuda",
                    subtitle: "Tire suas dúvidas",
                  ),

                  const SizedBox(height: 200),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE6AC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        "SAIR DO APP",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFBB718),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF8C4EFF), size: 30),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      contentPadding: EdgeInsets.zero,
    );
  }
}