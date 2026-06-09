import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final String nameCrypto;
  final String valueCrypto;
  final double valueCurrency;
  final VoidCallback onTap;
  final VoidCallback? onSell;

  const CryptoCard({
    super.key,
    required this.nameCrypto,
    required this.onTap,
    required this.valueCrypto,
    required this.valueCurrency,
    this.onSell,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
        child: Padding(
          padding: const EdgeInsetsGeometry.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF360B7A), 
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.trending_up, 
                        color: Color(0xffffffff),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsGeometry.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'R\$${valueCurrency.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                    ),
                  ),
                  if (onSell != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: GestureDetector(
                        onTap: onSell,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B6B),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            'Vender',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
