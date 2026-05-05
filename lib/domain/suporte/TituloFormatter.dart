import 'package:flutter/services.dart';

class TituloFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Separa o texto por espaços
    final palavras = newValue.text.split(' ');

    // Transforma a primeira letra de cada palavra em maiúscula e o resto em minúscula
    final formatado = palavras
        .map((palavra) {
          if (palavra.isEmpty) return palavra;

          return palavra[0].toUpperCase() + palavra.substring(1).toLowerCase();
        })
        .join(' ');

    return TextEditingValue(
      text: formatado,
      // Mantém a posição do cursor onde o usuário está digitando
      selection: newValue.selection,
    );
  }
}
