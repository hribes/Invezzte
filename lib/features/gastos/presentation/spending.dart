import 'package:flutter/material.dart' hide SearchBar;
import 'package:invezzte/core/widgets/NavBar.dart';
import 'package:invezzte/features/gastos/widgets/spending_header.dart';

class Spending extends StatelessWidget {
  const Spending({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: const SafeArea( //Para não sobrepor a barra do celular que aparece bateria, hora, etc.
        top: false,
        child: SingleChildScrollView( //PAra rolar a tela inteira verticalmente
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, //Para ocupar toda a largura da tela
            children: [
              //Aqui irei colocar os Widgets

              //1. Cabeçalho (SpendingHeader)
              SpendingHeader(),
              //2. Filtros (SpendingFilterList)
              //3. Data (SpendingDateHeader)
              //4. Transações (SpendingTransactionsList)

            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}