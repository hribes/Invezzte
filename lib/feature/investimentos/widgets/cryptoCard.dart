import 'package:flutter/material.dart';
import 'package:invezzte/feature/investimentos/widgets/graphic.dart';

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
          boxShadow: const [
            BoxShadow(
              color: Color(0x395E5E5E),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsGeometry.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: const BoxDecoration(
                          color: Color(
                            0xFF360B7A,
                          ), // Você também pode mudar essa cor se quiser
                          shape: BoxShape.circle,
                        ),
                        // 👇 É SÓ MUDAR AQUI 👇
                        child: const Icon(
                          Icons
                              .trending_up, // Substituído Icons.currency_bitcoin por Icons.trending_up
                          color: Color(0xffffffff),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsGeometry.all(10.0),
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
            const Padding(
              padding: EdgeInsetsGeometry.all(15),
              child: Graphic(),
            ),
          ],
        ),
      ),
    );
  }
}
