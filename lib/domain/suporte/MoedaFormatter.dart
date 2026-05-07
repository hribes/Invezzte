import 'package:flutter/services.dart';

class MoedaFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 1. Remove tudo o que não for número
    String novoTexto = newValue.text.replaceAll(RegExp(r'\D'), '');

    // 2. Se apagar tudo, mostra o valor base
    if (novoTexto.isEmpty) {
      return const TextEditingValue(
        text: '0,00',
        selection: TextSelection.collapsed(offset: 4),
      );
    }

    // 3. Limita a 12 caracteres para não quebrar o layout
    if (novoTexto.length > 12) {
      novoTexto = novoTexto.substring(0, 12);
    }

    // 4. Transforma em double e divide por 100 para ter os centavos
    double valor = double.parse(novoTexto) / 100;

    // 5. Formata manualmente para o padrão brasileiro
    // toStringAsFixed(2) garante as duas casas decimais
    // replaceAll('.', ',') troca o ponto decimal por vírgula
    String formatado = valor.toStringAsFixed(2).replaceAll('.', ',');

    // 6. (Opcional) Adiciona o ponto de milhar: 1000,00 -> 1.000,00
    formatado = _aplicarMilhar(formatado);

    return TextEditingValue(
      text: formatado,
      selection: TextSelection.collapsed(offset: formatado.length),
    );
  }

  String _aplicarMilhar(String valor) {
    List<String> partes = valor.split(',');
    String inteiro = partes[0];
    String centavos = partes[1];

    // Expressão regular que adiciona um ponto a cada 3 dígitos
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    inteiro = inteiro.replaceAll(reg, '.');

    return '$inteiro,$centavos';
  }
}
