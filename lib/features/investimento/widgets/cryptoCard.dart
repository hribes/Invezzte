import 'package:flutter/material.dart';
import 'package:invezzte/features/investimento/widgets/graphic.dart';

class CryptoCard extends StatelessWidget {
  final String nameCrypto;
  final String valueCrypto;
  final double valueCurrency;
  final VoidCallback onTap;

  const CryptoCard({
    super.key,
    required this.nameCrypto,
    required this.onTap,
    required this.valueCrypto,
    required this.valueCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: const Color(0x395E5E5E),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFFBB718),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.currency_bitcoin,
                          color: Color(0xffffffff),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              nameCrypto,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              valueCrypto,
                              style: const TextStyle(
                                color: Color(0xFF434343),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Text(
                    'R\$${valueCurrency.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsetsGeometry.all(15), child: Graphic()),
          ],
        ),
      ),
    );
  }
}
