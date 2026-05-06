import 'package:flutter/material.dart' hide SearchBar;
import 'package:invezzte/feature/widgets/HeaderScreens.dart';
import 'package:invezzte/feature/widgets/NavBar.dart';
import 'package:invezzte/feature/investimentos/widgets/buildCryptocurrencies.dart';
import 'package:invezzte/feature/investimentos/widgets/cryptoCard.dart';
import 'package:invezzte/feature/investimentos/widgets/graphic.dart';

class Investment extends StatelessWidget {
  const Investment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 450,
              decoration: const BoxDecoration(
                color: Color(0xFFE6E0F8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              
              child: SafeArea(
                bottom: false, // Só precisamos proteger a parte de cima
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                  child: Column(
                    children: [
                      // O seu componente genérico de Header
                      Headerscreens( // Se você usou o nome InvezztePageHeader, troque aqui
                        title: 'Investimentos', // Troquei de Gastos para Investimentos
                        firstIcon: Icons.search,
                        secondIcon: Icons.notifications,
                      ),
                      
                      // Textos de Patrimônio
                      const Padding(
                        padding: EdgeInsets.only(top: 10), // Corrigido o EdgeInsets
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Total de Patrimônio'),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "R\$98.548,11",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF434343),
                          ),
                        ),
                      ),
                      
                      // Gráfico
                      const Padding(
                        padding: EdgeInsets.only(top: 30), // Corrigido o EdgeInsets
                        child: Align(child: Graphic()),
                      )
                    ],
                  ),
                ),
              ),
            ),
            
            // Lista Horizontal de Categorias
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 40, 
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Criptomoedas(texto: 'BitCoin', onTap: () {}),
                    Criptomoedas(texto: 'Renda fixa', onTap: () {}),
                    Criptomoedas(texto: 'FIIS', onTap: () {}),
                    Criptomoedas(texto: 'Renda Variável', onTap: () {}),
                  ],
                ),
              ),
            ),

            // Card Único
            Align(
              child: CryptoCard(
                nameCrypto: 'Bitcoin',
                valueCrypto: '0,092 - BTC',
                valueCurrency: 33729.40,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}