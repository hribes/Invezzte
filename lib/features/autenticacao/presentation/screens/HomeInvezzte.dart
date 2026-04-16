import 'package:flutter/material.dart';
import 'package:invezzte/core/widgets/NavBar.dart';

class Homeinvezzte extends StatelessWidget {
  const Homeinvezzte({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: Color(0xFFDFD3FE),
                ),
                height: 200,
                child: const Center(
                  child: Text(
                    'Bem-vindo ao Invezzte!',
                    style: TextStyle(fontSize: 24, color: Color(0xFF885CFB)),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  10,
                  (index) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFF885CFB),
                      child: Text(
                        'A${index + 1}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text('Ativo ${index + 1}'),
                    subtitle: Text('Valor atual: R\$ ${(index + 1) * 100}'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: NavBar(),
    );
  }
}
