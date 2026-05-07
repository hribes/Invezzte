import 'package:flutter/services.dart';

class TelefoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitos = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Limita a 11 dígitos (DDD + número de celular) ou 10 (DDD + fixo).
    final limitado = digitos.length > 11 ? digitos.substring(0, 11) : digitos;

    // Aplica a máscara progressivamente conforme os dígitos são inseridos.
    final buffer = StringBuffer();
    for (int i = 0; i < limitado.length; i++) {
      if (i == 0) buffer.write('(');
      if (i == 2) buffer.write(') ');
      // Celular: 9 dígitos após o DDD → traço na posição 7
      // Fixo: 8 dígitos após o DDD → traço na posição 6
      if (limitado.length == 11 && i == 7) buffer.write('-');
      if (limitado.length <= 10 && i == 6) buffer.write('-');
      buffer.write(limitado[i]);
    }

    final textoFormatado = buffer.toString();

    return TextEditingValue(
      text: textoFormatado,
      selection: TextSelection.collapsed(offset: textoFormatado.length),
    );
  }
}
