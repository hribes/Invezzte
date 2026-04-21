import 'package:flutter/material.dart' hide SearchBar;
import 'package:invezzte/core/widgets/NavBar.dart';
import 'package:invezzte/features/investimento/widgets/buildCryptocurrencies.dart';
import 'package:invezzte/features/investimento/widgets/cryptoCard.dart';
import 'package:invezzte/features/investimento/widgets/graphic.dart';
import 'package:invezzte/features/investimento/widgets/notificationButton.dart';
import 'package:invezzte/features/investimento/widgets/searchBar.dart';

class Investment extends StatelessWidget {
  const Investment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                height: 450,
                decoration: BoxDecoration(
                  color: Color(0xFFDFD3FE),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),

                //Bloco roxo
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Investimentos',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SearchBar(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: NotificationButton(),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsetsGeometry.directional(top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Total de Patrimônio'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "R\$98.548,11",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF434343),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.directional(top: 30),
                      child: Align(child: Graphic()),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 40,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    child: CryptoCard(
                      nameCrypto: 'Bitcoin',
                      valueCrypto: '0,092 - BTC',
                      valueCurrency: 33729.40,
                      onTap: () {},
                    ),
                  ),
                ],
                // children: List.generate(
                //   10,
                //   (index) => ListTile(
                //     leading: CircleAvatar(
                //       backgroundColor: Color(0xFF885CFB),
                //       child: Text(
                //         'A${index + 1}',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     ),
                //     title: Text('Ativo ${index + 1}'),
                //     subtitle: Text('Valor atual: R\$ ${(index + 1) * 100}'),
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: NavBar(),
    );
  }
}
